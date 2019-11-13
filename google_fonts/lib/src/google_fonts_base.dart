// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Set<String> _loadedFonts = {};

Future<ByteData> fetchFont(String fontName, String fontUrl) async {
  print('fetchFont: $fontName');
  final response = await http.get(Uri.parse(fontUrl));

  if (response.statusCode == 200) {
    writeLocalFont(fontName, response.bodyBytes);
    return ByteData.view(response.bodyBytes.buffer);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load font');
  }
}

Future<void> loadFont(String fontName, String fontUrl) async {
  if (_loadedFonts.contains(fontName)) {
    return;
  }

  _loadedFonts.add(fontName);
  final fontLoader = FontLoader(fontName);
  var byteData = readLocalFont(fontName);
  if (await byteData == null) {
    byteData = fetchFont(fontName, fontUrl);
  }
  fontLoader.addFont(byteData);
  await fontLoader.load();
  print('loaded $fontName');
  // TODO: remove this once it is done automatically after loading a font.
  PaintingBinding.instance.handleSystemMessage({'type': 'fontsChange'});
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(String name) async {
  final path = await _localPath;
  return File('$path/$name.ttf');
}

Future<File> writeLocalFont(String name, List<int> bytes) async {
  print('writeLocalFont: $name');
  final file = await _localFile(name);
  return file.writeAsBytes(bytes);
}

Future<ByteData> readLocalFont(String name) async {
  print('readLocalFont: $name');
  try {
    final file = await _localFile(name);
    final fileExists = await file.exists();
    if (fileExists) {
      List<int> contents = await file.readAsBytes();
      if (contents != null && contents.isNotEmpty) {
        print('readLocalFont: $name EXISTS AND RETURNING');
        return ByteData.view(Uint8List.fromList(contents).buffer);
      }
    }
  } catch (e) {
    print('readLocalFont: $name ERROR');
    return null;
  }
  print('readLocalFont: $name DOES NOT EXIST');
  return null;
}

/// Function used to convert a [TextStyle] to a [String] that can be used to key
/// into results from the Google Fonts api.
///
/// For example:
///
///   fontUrlKey(
///     TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
///   )
///
/// Will yield
///
///   500italic
///
/// This will then be used to key into a json object like this:
///
/// "files": {
///   "regular": "http://fonts.gstatic.com/s/alegreyasc/v11/taiOGmRtCJ62-O0HhNEa-a6o05E5abe_.ttf",
///   "italic": "http://fonts.gstatic.com/s/alegreyasc/v11/taiMGmRtCJ62-O0HhNEa-Z6q2ZUbbKe_DGs.ttf",
///   "500": "http://fonts.gstatic.com/s/alegreyasc/v11/taiTGmRtCJ62-O0HhNEa-ZZc-rUxQqu2FXKD.ttf",
///   "500italic": "http://fonts.gstatic.com/s/alegreyasc/v11/taiRGmRtCJ62-O0HhNEa-Z6q4WEySK-UEGKDBz4.ttf",
///   "700": "http://fonts.gstatic.com/s/alegreyasc/v11/taiTGmRtCJ62-O0HhNEa-ZYU_LUxQqu2FXKD.ttf",
///   "700italic": "http://fonts.gstatic.com/s/alegreyasc/v11/taiRGmRtCJ62-O0HhNEa-Z6q4Sk0SK-UEGKDBz4.ttf",
/// }
String fontUrlKey(TextStyle textStyle) {
  if (textStyle == null ||
      (textStyle.fontWeight == FontWeight.w400 &&
          textStyle.fontStyle != FontStyle.italic)) {
    return 'regular';
  }
  return '${_fontWeightString(textStyle)}'
      '${_fontStyleString(textStyle.fontStyle)}';
}

String _fontWeightString(TextStyle textStyle) {
  if (textStyle.fontWeight == null || textStyle.fontWeight == FontWeight.w400) {
    return '';
  }
  return textStyle.fontWeight.toString().replaceAll('FontWeight.w', '');
}

String _fontStyleString(FontStyle fontstyle) {
  if (fontstyle == FontStyle.italic) {
    return 'italic';
  }
  return '';
}
