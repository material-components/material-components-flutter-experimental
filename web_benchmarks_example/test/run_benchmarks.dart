import 'dart:convert' show JsonEncoder;
import 'dart:io';

import 'package:web_benchmarks/server.dart';

Future<void> main() async {
  final taskResult = await serveWebBenchmark(
    benchmarkAppDirectory: Directory('.'),
    entryPoint: 'lib/benchmarks/runner.dart',
    useCanvasKit: false,
  );
  print(JsonEncoder.withIndent('  ').convert(taskResult.toJson()));
}
