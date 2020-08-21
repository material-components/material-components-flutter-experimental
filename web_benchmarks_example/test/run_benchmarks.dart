import 'dart:convert' show JsonEncoder;

import 'package:web_benchmarks_framework/server.dart';

Future<void> main () async {
  final taskResult = await runWebBenchmark(
    macrobenchmarksDirectory: '.',
    entryPoint: 'lib/benchmarks/runner.dart',
    useCanvasKit: false,
  );
  print (JsonEncoder.withIndent('  ').convert(taskResult.toJson()));
}

