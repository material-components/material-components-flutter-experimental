import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:theme_generator/constants.dart';
import 'package:theme_generator/theme_app.dart';
import 'package:theme_generator/data/theme_options.dart';
import 'package:theme_generator/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: ThemeOptions(
          lightThemeData: ThemeData(),
          themeMode: ThemeMode.light,
          textScaleFactor: systemTextScaleFactorOption,
          platform: defaultTargetPlatform,
          selectedScheme: SelectedScheme.PrimaryColor),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Flutter Theme Generator',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeOptions.of(context).themeMode,
          theme: ThemeAppThemeData.lightThemeData.copyWith(
            platform: ThemeOptions.of(context).platform,
          ),
          darkTheme: ThemeAppThemeData.darkThemeData.copyWith(
            platform: ThemeOptions.of(context).platform,
          ),
          home: HomePage(),
        );
      }),
    );
  }
}
