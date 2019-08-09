import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_flutter_io19/fortnightly/countertop/countertop.dart';
import 'package:material_flutter_io19/fortnightly/foldable_open/foldable_open.dart';
import 'package:material_flutter_io19/fortnightly/phone_portrait/phone_portrait.dart';
import 'package:material_flutter_io19/fortnightly/tv/tv.dart';
import 'package:material_flutter_io19/fortnightly/wearable/wristwatch.dart';

void main(List<String> args) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  return runApp(FortnightlyAdaptive());
}

enum DeviceType {countertop, foldable, tv, wristwatch}

class FortnightlyAdaptive extends StatelessWidget {
  final DeviceType deviceType = DeviceType.countertop;

  @override
  Widget build(BuildContext context) {
    switch (deviceType) {
      case DeviceType.countertop:
        SystemChrome.setEnabledSystemUIOverlays([]);
        return FortnightlyCountertop();
        break;
      case DeviceType.foldable:
        return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          final Size size = constraints.biggest;
          final double aspectRatio = size.width / size.height;
          if (aspectRatio < 0.7) {
            return FortnightlyPhonePortrait();
          } else {
            return FortnightlyFoldableOpen();
          }
        });
        break;
      case DeviceType.tv:
        SystemChrome.setEnabledSystemUIOverlays([]);
        return FortnightlyTv();
        break;
      case DeviceType.wristwatch:
        SystemChrome.setEnabledSystemUIOverlays([]);
        return FortnightlyWristwatch();
        break;
    }
  }
}