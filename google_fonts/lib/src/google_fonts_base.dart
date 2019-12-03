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
  List<GoogleFontsFamily> fonts,
}) {
  textStyle ??= TextStyle();
  textStyle = textStyle.copyWith(fontWeight: fontWeight, fontStyle: fontStyle);

  final font = closestMatch(GoogleFontsFamily.fromTextStyle(textStyle), fonts);
  final googleFontsFontFamily = '$fontFamily${font.toString()}';

  loadFontIfNecessary(fontFamily, font.url);
  return textStyle.copyWith(
    fontFamily: googleFontsFontFamily,
    fontFamilyFallback: [fontFamily],
  );
}

/// Loads a font into the [FontLoader] with [fontName] for the matching
/// [fontUrl].
///
/// If a font with the [fontName] has already been loaded into memory, then
/// this method does nothing as there is no need to load it a second time.
///
/// Otherwise, this method will first check to see if the font is available on
/// disk. If it is, then it loads it into the [FontLoader]. If it is not on
/// disk, then it fetches it via the [fontUrl], stores it on disk, and loads it
/// into the [FontLoader].
Future<void> loadFontIfNecessary(String fontName, String fontUrl) async {
  // If this font has already been loaded, then there is no need to load it
  // again.
  if (_loadedFonts.contains(fontName)) {
    return;
  }

  // If this font can be loaded by the pre-bundled assets, then there is no
  // need to load it at all.
  final fontsJson = await _loadFontManifestJson();
  print('fontsJson: ${fontsJson.toString()}');
  if (_hasFontName(fontName, fontsJson)) {
    return;
  }

  _loadedFonts.add(fontName);
  final fontLoader = FontLoader(fontName);
  var byteData = _readLocalFont(fontName);
  if (await byteData == null) {
    byteData = _httpFetchFont(fontName, fontUrl);
  }
  fontLoader.addFont(byteData);
  await fontLoader.load();
  // TODO: Remove this once it is done automatically after loading a font.
  // https://github.com/flutter/flutter/issues/44460
  PaintingBinding.instance.handleSystemMessage({'type': 'fontsChange'});
}

// Returns [GoogleFontsFamily] from `variants` that most closely matches
// [style] according to the computeMatch scoring function.
//
// This logic is taken from the following section of the minikin library, which
// is ultimately how flutter handles matching fonts.
// https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L149
GoogleFontsFamily closestMatch(
  GoogleFontsFamily style,
  List<GoogleFontsFamily> variants,
) {
  int bestScore;
  GoogleFontsFamily bestMatch;
  for (var variant in variants) {
    final score = _computeMatch(style, variant);
    if (bestScore == null || score < bestScore) {
      bestScore = score;
      bestMatch = variant;
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

bool _hasFontName(String fontName, dynamic fontsJson) {
  final fontNameChunks = fontName.split('-');
  final fontFamily = fontNameChunks[0];
  final googleFontsFamilyString = fontNameChunks.length > 1 ? fontNameChunks[1] : '';
  final googleFontsFamily = GoogleFontsFamily.fromString(googleFontsFamilyString);

  for (final fontFamilyJson in fontsJson) {
    print('fontFamilyJson->family' + fontFamilyJson['family'] );
    if (fontFamilyJson['family'] == fontFamily) {
      for (final fontJson in fontFamilyJson['fonts']) {
        final fontWeight = (googleFontsFamily.fontWeight + 1) * 100;
        final fontStyle = googleFontsFamily.fontStyle.toString().replaceAll('FontStyle.', '');
        final matchesWeight = fontWeight == 400 && fontJson['weight'] == null || fontJson['weight'] == fontWeight;
        final matchesStyle = fontStyle == 'regular' && fontJson('regular') == null || fontJson['style'] == fontStyle;
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
  const GoogleFontsVariant(this.fontWeight, this.fontStyle);

  final FontWeight fontWeight;
  final FontStyle fontStyle;
}

class GoogleFontsFamily {
  const GoogleFontsFamily(this.fontWeight, this.fontStyle, [this.url]);

  // The FontWeight as an index [0-8] representing the font weights 100-900.
  final int fontWeight;
  final FontStyle fontStyle;
  final String url;

  // From a string key, for example, `500italic`.
  GoogleFontsFamily.fromString(String key, [this.url])
      : this.fontWeight = key == _regular || key == _italic
            ? 3
            : (int.parse(key.replaceAll(_italic, '')) ~/ 100) - 1,
        this.fontStyle =
            key.contains(_italic) ? FontStyle.italic : FontStyle.normal;

  GoogleFontsFamily.fromTextStyle(TextStyle style, [this.url])
      : this.fontWeight = style?.fontWeight?.index ?? 3,
        this.fontStyle = style?.fontStyle ?? FontStyle.normal;

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
    final GoogleFontsFamily typedOther = other;
    return typedOther.fontWeight == fontWeight &&
        typedOther.fontStyle == fontStyle;
  }
}

// This logic is taken from the following section of the minikin library, which
// is ultimately how flutter handles matching fonts.
// * https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L128
int _computeMatch(GoogleFontsFamily a, GoogleFontsFamily b) {
  if (a == b) {
    return 0;
  }
  int score = (a.fontWeight - b.fontWeight).abs();
  if (a.fontStyle != b.fontStyle) {
    score += 2;
  }
  return score;
}

const _regular = 'regular';
const _italic = 'italic';
