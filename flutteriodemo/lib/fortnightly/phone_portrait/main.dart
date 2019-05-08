import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_flutter_io19/app.dart';

import 'package:material_flutter_io19/fortnightly/phone_portrait/phone_portrait.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
  ]);
  return runApp(FortnightlyPhonePortrait());
}