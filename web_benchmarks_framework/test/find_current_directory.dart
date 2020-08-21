import 'dart:io';
import 'package:web_benchmarks_framework/framework/utils.dart';

Future<void> main () async {
  // Get flutter directory.
  String flutterLocation = await eval(
    'which',
    ['flutter'],
  );
  print (Directory(flutterLocation).parent.parent);
}
