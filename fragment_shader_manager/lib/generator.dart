// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:collection';
import 'dart:io';

import 'package:args/args.dart';
import 'package:mustache/mustache.dart';
import 'package:recase/recase.dart';

const inputFilePrefixOption = 'input_file_prefix';
const outputFilePrefixOption = 'output_file_prefix';
const formatWithNewlinesFlag = 'format_with_newlines';

const space = ' ';
const twoSpaces = '  ';
const generatedCodeHeader = '// GENERATED FILE - DO NOT EDIT';

Future<void> main(List<String> arguments) async {
  // Parse the command line args for input and output paths.
  final parser = ArgParser()
    ..addOption(inputFilePrefixOption, abbr: 'i')
    ..addOption(outputFilePrefixOption, abbr: 'o')
    ..addFlag(formatWithNewlinesFlag, abbr: 'f', defaultsTo: false);
  final argResults = parser.parse(arguments);

  // Read in the glsl as a string and spirv binary as a list of bytes.
  final inputFilePrefix = argResults[inputFilePrefixOption].toString();

  // TODO(clocksmith): Also check for .frag extension.
  final glslPath = '$inputFilePrefix.glsl';
  print('Reading GLSL string from $glslPath');
  final glslString = await File(glslPath).readAsString();

  final spvPath = '$inputFilePrefix.spv';
  print('Reading SPIR-V bytes from $spvPath');
  final spirvBytes = await File(spvPath).readAsBytes();

  final spirvBytesStringBuffer = StringBuffer();
  spirvBytesStringBuffer.write('[');
  final formatWithNewlines = argResults[formatWithNewlinesFlag];
  var byteCount = 0;
  var newline = () { return byteCount % 4 == 0 && formatWithNewlines; };
  if (newline()) spirvBytesStringBuffer.writeln();
  for (final byte in spirvBytes) {
    if (newline()) spirvBytesStringBuffer.write(twoSpaces);
    spirvBytesStringBuffer.write(
      '0x${byte.toRadixString(16).padLeft(2, '0').toUpperCase()},');
    byteCount++;
    if (newline()) spirvBytesStringBuffer.writeln();
  }
  spirvBytesStringBuffer.write(']');
  final spirvByteList = spirvBytesStringBuffer.toString();

  print('Reading GLSL lines from $glslPath');
  final glslLines = await File(glslPath).readAsLines();
  final uniforms = _parseUniforms(glslLines);

  final outputFilePrefix = argResults[outputFilePrefixOption].toString();
  final constructorName = _glslNameToFlutterName(outputFilePrefix);

  final template = Template(
    File('fragment_shader_manager.tmpl').readAsStringSync(),
    htmlEscapeValues: false,
  );
  final generatedDartString = template.renderString({
    'generatedCodeHeader': generatedCodeHeader,
    'glslString': glslString,
    'spirvByteList': spirvByteList,
    'uniforms': uniforms,
    'constructorName': constructorName,
  });

  // Create and save the output file. Existing files will not be overwritten,
  // but when running this script from a genrule, there will not be a different
  // existing file in the output directory.
  final outputFilePath = '$outputFilePrefix.g.dart';
  final outFile = File(outputFilePath); await outFile.create(recursive: true);
  print('Writing generated file');
  await outFile.writeAsString(generatedDartString);
}

// TODO(clocksmith): Parse sampler unifroms in addition to float uniforms.
SplayTreeMap<int, UniformData> _parseUniforms(List<String> glslLines) {
  final uniformsMap = SplayTreeMap<int, UniformData>();

  // Looking for lines like: layout(location = 1) uniform float u_time;
  final spacelessLocationLineStart = 'layout(location';
  for (final line in glslLines) {
    if (line.contains(' uniform ')) {
      int? locationIndex;
      final spacelessLine = line.replaceAll(' ', '');
      if (spacelessLine.startsWith(spacelessLocationLineStart)) {
        locationIndex = int.tryParse(
          spacelessLine[spacelessLocationLineStart.length + 1]);
        if (locationIndex == null) throw FormatException('Invalid GLSL');
        final chunks = line.split(' ');
        try {
          final type = chunks[chunks.length - 2];
          final name = chunks[chunks.length - 1];
          uniformsMap[locationIndex] = UniformData(
            type: _glslTypeToFlutterType(type),
            name: _glslNameToFlutterName(name.replaceAll(';', '')),
            toFloatTemplatePrefix: _glslTypeToFlutterFloatTemplatePrefix(type),
            toFloatTemplateSuffix: _glslTypeToFlutterFloatTemplateSuffix(type),
          );
        } catch (e) {
          throw FormatException('Invalid GLSL: $e');
        }
      }
    }
  }

  return uniformsMap;
}

String _glslTypeToFlutterType(String type) {
  final flutterType = _glslTypeToFlutterTypeMap[type];
  if (flutterType == null) {
    throw FormatException('Unsupported uniform type: $type');
  }
  return flutterType;
}

const _glslTypeToFlutterTypeMap = <String, String>{
  'float': 'double',
  'vec2': 'Vector2',
  'vec3': 'Vector3',
  'vec4': 'Vector4',
  'mat2x2': 'Matrix2',
  'mat3x3': 'Matrix3',
  'mat4x4': 'Matrix4',
};

String _glslNameToFlutterName(String type) => type.camelCase;

String _glslTypeToFlutterFloatTemplatePrefix(String type) {
  final template = _glslTypeToFlutterFloatTemplatePrefixes[type];
  if (template == null) {
    throw FormatException('Unsupported uniform type: $type');
  }
  return template;
}
const _glslTypeToFlutterFloatTemplatePrefixes = <String, String>{
  'float': '[',
  'vec2': _vectorOrMatrixTemplatePrefix,
  'vec3': _vectorOrMatrixTemplatePrefix,
  'vec4': _vectorOrMatrixTemplatePrefix,
  'mat2x2': _vectorOrMatrixTemplatePrefix,
  'mat3x3': _vectorOrMatrixTemplatePrefix,
  'mat4x4': _vectorOrMatrixTemplatePrefix,
};
const _vectorOrMatrixTemplatePrefix = '';

String _glslTypeToFlutterFloatTemplateSuffix(String type) {
  final template = _glslTypeToFlutterFloatTemplateSuffixes[type];
  if (template == null) {
    throw FormatException('Unsupported uniform type: $type');
  }
  return template;
}
const _glslTypeToFlutterFloatTemplateSuffixes = <String, String>{
  'float': ']',
  'vec2': _vectorOrMatrixTemplateSuffix,
  'vec3': _vectorOrMatrixTemplateSuffix,
  'vec4': _vectorOrMatrixTemplateSuffix,
  'mat2x2': _vectorOrMatrixTemplateSuffix,
  'mat3x3': _vectorOrMatrixTemplateSuffix,
  'mat4x4': _vectorOrMatrixTemplateSuffix,
};
const _vectorOrMatrixTemplateSuffix = '.storage';

/// Data needed by manager related to uniforms.
class UniformData {
  UniformData({
    required this.type,
    required this.name,
    required this.toFloatTemplatePrefix,
    required this.toFloatTemplateSuffix,
  });

  final String type;
  final String name;
  final String toFloatTemplatePrefix;
  final String toFloatTemplateSuffix;
}