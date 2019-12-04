// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// Keep track of the loaded fonts in FontLoader for the life of the app
// instance.
final Set<String> _loadedFonts = {};

@visibleForTesting
http.Client httpClient = http.Client();

@visibleForTesting
void clearCache() => _loadedFonts.clear();

/// Creates a [TextStyle] that either uses the font family for the requested
/// GoogleFont, or falls back to the pre-bundled font family.
///
/// This function has a side effect of loading the font into the [FontLoader],
/// either by network or from the file system.
TextStyle googleFontsTextStyle({
  String fontFamily,
  TextStyle textStyle,
  FontWeight fontWeight,
  FontStyle fontStyle,
  Map<GoogleFontsVariant, String> fonts,
}) {
  textStyle ??= TextStyle();
  textStyle = textStyle.copyWith(fontWeight: fontWeight, fontStyle: fontStyle);

  final variant = _closestMatch(
      GoogleFontsVariant(
        fontWeight: textStyle.fontWeight,
        fontStyle: textStyle.fontStyle,
      ),
      fonts.keys);
  final descriptor = GoogleFontsDescriptor(
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    fontUrl: fonts[variant],
  );

  loadFontIfNecessary(descriptor);

  return textStyle.copyWith(
    fontFamily: descriptor.familyWithVariant(),
    fontFamilyFallback: [fontFamily],
  );
}

/// Loads a font into the [FontLoader] with [googleFontsFamilyName] for the
/// matching [fontUrl].
///
/// If a font with the [fontName] has already been loaded into memory, then
/// this method does nothing as there is no need to load it a second time.
///
/// Otherwise, this method will first check to see if the font is available on
/// disk. If it is, then it loads it into the [FontLoader]. If it is not on
/// disk, then it fetches it via the [fontUrl], stores it on disk, and loads it
/// into the [FontLoader].
Future<void> loadFontIfNecessary(GoogleFontsDescriptor descriptor) async {
  final familyWithVariant = descriptor.familyWithVariant();
  // If this font has already been loaded, then there is no need to load it
  // again.
  if (_loadedFonts.contains(familyWithVariant)) {
    return;
  }

  // If this font can be loaded by the pre-bundled assets, then there is no
  // need to load it at all.
  final fontsJson = await _loadFontManifestJson();
  print('fontsJson: ${fontsJson.toString()}');
  if (_isPrebundled(familyWithVariant, fontsJson)) {
    return;
  }

  _loadedFonts.add(familyWithVariant);
  final fontLoader = FontLoader(familyWithVariant);
  var byteData = _readLocalFont(familyWithVariant);
  if (await byteData == null) {
    byteData = _httpFetchFont(familyWithVariant, descriptor.fontUrl);
  }
  fontLoader.addFont(byteData);
  await fontLoader.load();
  // TODO: Remove this once it is done automatically after loading a font.
  // https://github.com/flutter/flutter/issues/44460
  PaintingBinding.instance.handleSystemMessage({'type': 'fontsChange'});
}

// Returns [GoogleFontsVariant] from [variantsToCompare] that most closely
// matches [sourceVariant] according to the [_computeMatch] scoring function.
//
// This logic is derived from the following section of the minikin library,
// which is ultimately how flutter handles matching fonts.
// https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L149
GoogleFontsVariant _closestMatch(
  GoogleFontsVariant sourceVariant,
  Iterable<GoogleFontsVariant> variantsToCompare,
) {
  int bestScore;
  GoogleFontsVariant bestMatch;
  for (final variantToCompare in variantsToCompare) {
    final score = _computeMatch(sourceVariant, variantToCompare);
    if (bestScore == null || score < bestScore) {
      bestScore = score;
      bestMatch = variantToCompare;
    }
  }
  return bestMatch;
}

/// Fetches a font with [fontName] from the [fontUrl] and saves it locally if
/// it is the first time it is being loaded.
///
/// This function can return null if the font fails to load from the URL.
Future<ByteData> _httpFetchFont(String fontName, String fontUrl) async {
  final uri = Uri.tryParse(fontUrl);
  if (uri == null) {
    throw Exception('Invalid fontUrl: $fontUrl');
  }

  final response = await httpClient.get(uri);
  if (response.statusCode == 200) {
    _writeLocalFont(fontName, response.bodyBytes);
    return ByteData.view(response.bodyBytes.buffer);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load font with url: $fontUrl');
  }
}

Future<List<dynamic>> _loadFontManifestJson() async {
  return rootBundle.loadStructuredData('FontManifest.json', (s) async {
    return json.decode(s);
  });
}

bool _isPrebundled(String fontName, dynamic fontsJson) {
  final fontNameChunks = fontName.split('-');
  final fontFamily = fontNameChunks[0];
  final googleFontsFamilyString =
      fontNameChunks.length > 1 ? fontNameChunks[1] : '';
  final googleFontsFamily =
      GoogleFontsDescriptor.fromFamilyWithVariant(googleFontsFamilyString);

  for (final fontFamilyJson in fontsJson) {
    print('fontFamilyJson->family' + fontFamilyJson['family']);
    if (fontFamilyJson['family'] == fontFamily) {
      for (final fontJson in fontFamilyJson['fonts']) {
        final fontWeight = (googleFontsFamily.fontWeight + 1) * 100;
        final fontStyle =
            googleFontsFamily.fontStyle.toString().replaceAll('FontStyle.', '');
        final matchesWeight = fontWeight == 400 && fontJson['weight'] == null ||
            fontJson['weight'] == fontWeight;
        final matchesStyle =
            fontStyle == 'regular' && fontJson('regular') == null ||
                fontJson['style'] == fontStyle;
        if (matchesWeight && matchesStyle) {
          return true;
        }
      }
    }
  }
  return false;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(String name) async {
  final path = await _localPath;
  return File('$path/$name.ttf');
}

Future<File> _writeLocalFont(String name, List<int> bytes) async {
  final file = await _localFile(name);
  return file.writeAsBytes(bytes);
}

Future<ByteData> _readLocalFont(String name) async {
  try {
    final file = await _localFile(name);
    final fileExists = file.existsSync();
    if (fileExists) {
      List<int> contents = await file.readAsBytes();
      if (contents != null && contents.isNotEmpty) {
        return ByteData.view(Uint8List.fromList(contents).buffer);
      }
    }
  } catch (e) {
    return null;
  }
  return null;
}

class GoogleFontsVariant {
  const GoogleFontsVariant({
    @required this.fontWeight,
    @required this.fontStyle,
  });

  GoogleFontsVariant.fromString(String variantString)
      : this.fontWeight = FontWeight.values[variantString == _regular ||
                variantString == _italic
            ? 3
            : (int.parse(variantString.replaceAll(_italic, '')) ~/ 100) - 1],
        this.fontStyle = variantString.contains(_italic)
            ? FontStyle.italic
            : FontStyle.normal;

  final FontWeight fontWeight;
  final FontStyle fontStyle;

  @override
  String toString() {
    final fontWeightString = (fontWeight.index ?? 3 + 1) * 100;
    final fontStyleString = fontStyle.toString().replaceAll('FontStyle.', '');
    return '$fontWeightString$fontStyleString';
  }

  @override
  int get hashCode => hashValues(fontWeight, fontStyle);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final GoogleFontsDescriptor typedOther = other;
    return typedOther.fontWeight == fontWeight &&
        typedOther.fontStyle == fontStyle;
  }
}

class GoogleFontsDescriptor {
  const GoogleFontsDescriptor({
    this.fontFamily,
    this.fontWeight,
    this.fontStyle,
    this.fontUrl,
  });

  final String fontFamily;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final String fontUrl;

//  // From a string key, for example, `500italic`.
//  GoogleFontsDescriptor.fromVariantStringAndUrl({
//    String variantString,
//    this.fontUrl,
//  })  : this.fontWeight = key == _regular || key == _italic
//            ? 3
//            : (int.parse(key.replaceAll(_italic, '')) ~/ 100) - 1,
//        this.fontStyle =
//            key.contains(_italic) ? FontStyle.italic : FontStyle.normal;

//  GoogleFontsDescriptor.fromTextStyle(TextStyle style, [this.fontUrl])
//      : this.fontWeight = style?.fontWeight?.index ?? 3,
//        this.fontStyle = style?.fontStyle ?? FontStyle.normal;

  String familyWithVariant() {
    final variantString = GoogleFontsVariant(fontWeight: fontWeight, fontStyle: fontStyle).toString();
    return '$fontFamily$variantString';
  }

  @override
  String toString() {
    // TODO(clocksmith): Extract each sub string into a function.
    final fontWeightString = (fontWeight + 1) * 100;
    final fontStyleString = fontStyle.toString().replaceAll('FontStyle.', '');
    return '$fontWeightString$fontStyleString';
  }

  @override
  int get hashCode => hashValues(fontWeight, fontStyle);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final GoogleFontsDescriptor typedOther = other;
    return typedOther.fontWeight == fontWeight &&
        typedOther.fontStyle == fontStyle;
  }
}

// This logic is taken from the following section of the minikin library, which
// is ultimately how flutter handles matching fonts.
// * https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L128
int _computeMatch(GoogleFontsVariant a, GoogleFontsVariant b) {
  if (a == b) {
    return 0;
  }
  int score = (a.fontWeight.index - b.fontWeight.index).abs();
  if (a.fontStyle != b.fontStyle) {
    score += 2;
  }
  return score;
}

const _regular = 'regular';
const _italic = 'italic';
