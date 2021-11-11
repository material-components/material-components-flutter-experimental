import 'dart:io';

import 'package:args/args.dart';
import 'package:logging/logging.dart';

const inputFileOption = 'input_file';
const outputFileOption = 'output_file';
const formatWithNewlinesFlag = 'format_with_newlines';

const space = ' ';
const twoSpaces = '  ';

Future<void> main(List<String> arguments) async {
  final log = Logger('main');

  // Parse the command line args for input and output paths.
  final parser = ArgParser()
    ..addOption(inputFileOption, abbr: 'i')
    ..addOption(outputFileOption, abbr: 'o')
    ..addFlag(formatWithNewlinesFlag, abbr: 'f', defaultsTo: false);
  final argResults = parser.parse(arguments);

  // Read in the spirv binary as a list of bytes.
  final inputFilePath = argResults[inputFileOption].toString();
  log.info('Reading spirv bytes from $inputFilePath');
  final bytes = await File(inputFilePath).readAsBytes();

  final out = StringBuffer();
  out.write('''
// GENERATED FILE - DO NOT EDIT

import 'dart:typed_data';

/// A class for managing [FragmentShaderBuilder] that includes a pre-transpiled
/// shader program into SPIR-V.
///
/// Words in SPIR-V are 32 bits. Every 4 elements in this list represents 1
/// SPIR-V word. See https://www.khronos.org/registry/SPIR-V/.

/// TODO(clocksmith): add original source glsl and/or spvasm as commented text.
''');

  // Create a const Uint8List that is created from the spirv bytes.
  out.write('final spirv = Uint8List.fromList([');
  final formatWithNewlines = argResults[formatWithNewlinesFlag];
  var byteCount = 0;
  var newline = () { return byteCount % 4 == 0 && formatWithNewlines; };
  if (newline()) out.writeln();
  for (final byte in bytes) {
    if (newline()) out.write(twoSpaces);
    out.write('0x${byte.toRadixString(16).padLeft(2, '0').toUpperCase()},');
    byteCount++;
    if (newline()) out.writeln();
  }
  out.write(']);');

  // Create and save the output file. Existing files will not be overwritten,
  // but when running this script from a genrule, there will not be a different
  // existing file in the output directory.
  final outputFilePath = argResults[outputFileOption].toString();
  final outFile = File(outputFilePath);
  await outFile.create(recursive: true);
  log.info('Writing spirv Uint8List to $outputFilePath');
  await outFile.writeAsString(out.toString());
}