import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'foldable_open.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  return runApp(FortnightlyFoldableOpen());
}