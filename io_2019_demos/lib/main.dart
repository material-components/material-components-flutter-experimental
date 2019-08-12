import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_flutter_io19/app.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
  ]);
  return runApp(IoApp());
}
