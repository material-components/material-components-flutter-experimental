// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import '../src/google_fonts_base.dart';
import 'package:mustache/mustache.dart';

void main() {
  final fontsJsonData = readFontsJsonData();

  final outFile = File('lib/google_fonts.g.dart');
  final outFileWriteSink = outFile.openWrite();

  final methods = [];

  for (final item in fontsJsonData['items']) {
    final family = item['family'].toString().replaceAll(' ', '');
    final lowerFamily = family[0].toLowerCase() + family.substring(1);

    final variants = <GoogleFontsFamily>[];
    for (final variant in item['variants']) {
      variants.add(
        GoogleFontsFamily.fromString(variant, item['files'][variant]),
      );
    }

    methods.add({
      'methodName': '$lowerFamily',
      'fontFamily': family,
      'fontUrls': [
        for (final variant in variants)
          {
            'weight': variant.fontWeight,
            'stye': variant.fontStyle,
            'url': variant.url,
          }
      ],
    });
  }

  final template = Template(
    File('lib/generator/google_fonts.tmpl').readAsStringSync(),
    htmlEscapeValues: false,
  );
  final result = template.renderString({'method': methods});

  outFileWriteSink.write(result);
  outFileWriteSink.close();
}

Map readFontsJsonData() {
  final fontsJsonFile = File('lib/data/fonts_data.json');
  final fontsJsonString = fontsJsonFile.readAsStringSync();
  return jsonDecode(fontsJsonString);
}
