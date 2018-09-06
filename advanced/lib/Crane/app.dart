// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

import 'backdrop.dart';
import 'colors.dart';
import 'home.dart';
import 'menu_page.dart';
import 'fly_form.dart';
import 'sleep_form.dart';
import 'eat_form.dart';


class CraneApp extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _CraneAppState createState() => new _CraneAppState();
}

class _CraneAppState extends State<CraneApp> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      title: 'Crane',
      home: Backdrop(
        frontLayer: HomePage(),
        backLayer: <Widget> [
          FlyForm(),
          SleepForm(),
          EatForm(),
          MenuPage(),
        ],
        frontTitle: Text('CRANE'),
        backTitle: Text('MENU'),
      ),
      initialRoute: '/',
      onGenerateRoute: _getRoute,
      theme: _kCraneTheme,
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => CraneApp(),
    fullscreenDialog: true,
  );
}


final ThemeData _kCraneTheme = _buildCraneTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kCranePrimaryWhite);
}

ThemeData _buildCraneTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    accentColor: kCranePurple700,
    primaryColor: kCranePurple800,
    buttonColor: kCraneRed700,
    hintColor: kCranePrimaryWhite,
    indicatorColor: kCranePrimaryWhite,
    scaffoldBackgroundColor: kCranePrimaryWhite,
    cardColor: kCranePrimaryWhite,
    textSelectionColor: kCranePurple700,
    errorColor: kCraneErrorOrange,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
  // these text themes come from ThemeData.light?
    textTheme: _buildCraneTextTheme(base.textTheme),
    primaryTextTheme: _buildCraneTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildCraneTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildCraneTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
        fontSize: 16.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
    ),
    body2: base.body2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
    ),

  ).apply(
    fontFamily: 'Raleway',
  );
}
