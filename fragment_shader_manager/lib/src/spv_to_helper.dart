import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';

const inputFilePrefixOption = 'input_file_prefix';
const outputFilePrefixOption = 'output_file_prefix';
const formatWithNewlinesFlag = 'format_with_newlines';

const space = ' ';
const twoSpaces = '  ';

Future<void> main(List<String> arguments) async {
  final log = Logger('main');

  // Parse the command line args for input and output paths.
  final parser = ArgParser()
    ..addOption(inputFilePrefixOption, abbr: 'i')
    ..addOption(outputFilePrefixOption, abbr: 'o')
    ..addFlag(formatWithNewlinesFlag, abbr: 'f', defaultsTo: false);
  final argResults = parser.parse(arguments);

  // Read in the glsl as a string and spirv binary as a list of bytes.
  final inputFilePrefix = argResults[inputFilePrefixOption].toString();
  log.info('Reading GLSL string from $inputFilePrefix');
  final glslString = await File('$inputFilePrefix.glsl').readAsString();
  log.info('Reading SPIR-V bytes from $inputFilePrefix');
  final spirvBytes = await File('$inputFilePrefix.spv').readAsBytes();

  final out = StringBuffer();
  out.write('''
// GENERATED FILE - DO NOT EDIT

import 'dart:typed_data';

/// A class for managing [FragmentProgram] that includes a pre-transpiled
/// shader program into SPIR-V.
///
/// Words in SPIR-V are 32 bits. Every 4 elements in this list represents 1
/// SPIR-V word. See https://www.khronos.org/registry/SPIR-V/.

/// TODO(clocksmith): add original source glsl and/or spvasm as static strings and/or commented text.
''');

  // Create a const Uint8List that is created from the spirv bytes.
  out.write('final spirv = Uint8List.fromList([');
  final formatWithNewlines = argResults[formatWithNewlinesFlag];
  var byteCount = 0;
  var newline = () { return byteCount % 4 == 0 && formatWithNewlines; };
  if (newline()) out.writeln();
  for (final byte in spirvBytes) {
    if (newline()) out.write(twoSpaces);
    out.write('0x${byte.toRadixString(16).padLeft(2, '0').toUpperCase()},');
    byteCount++;
    if (newline()) out.writeln();
  }
  out.write(']);');

  // Create and save the output file. Existing files will not be overwritten,
  // but when running this script from a genrule, there will not be a different
  // existing file in the output directory.
  final outputFilePrefix = argResults[outputFilePrefixOption].toString();
  final outputFilePath = '$outputFilePrefix.g.dart';
  final outFile = File(outputFilePath); await outFile.create(recursive: true);
  log.info('Writing spirv Uint8List to $outputFilePath');
  await outFile.writeAsString(out.toString());
}