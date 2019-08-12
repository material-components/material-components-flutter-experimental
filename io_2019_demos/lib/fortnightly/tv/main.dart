import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'tv.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(FortnightlyTv());
}