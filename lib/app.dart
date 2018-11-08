import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/home.dart';
import 'package:rally_proto/login.dart';

class RallyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rally Proto',
      theme: _buildRallyTheme(),
      home: HomePage(),
      initialRoute: '/login',
      routes: {
        '/login': (BuildContext context) => LoginPage()
      },
    );
  }

  ThemeData _buildRallyTheme() {
    final ThemeData base = ThemeData.dark();
    return ThemeData(
      scaffoldBackgroundColor: RallyColors.bgColor,
      primarySwatch: RallyColors.primaryGreen,
      textTheme: _buildRallyTextTheme(base.textTheme),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500
        ),
        filled: true,
        fillColor: Color(0xFF26282F),
        focusedBorder: InputBorder.none,
      ),
    );
  }

  TextTheme _buildRallyTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(
        fontFamily: "Roboto Condensed",
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(fontSize: 18.0),
      caption: base.caption.copyWith(
        fontFamily: "Roboto RallyCondensed",
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
      body1:base.body1.copyWith(
        fontFamily: "Roboto Condensed",
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
      body2: base.body2.copyWith(
        fontFamily: "Eczar",
        fontSize: 14.0,
      ),
      button: base.button.copyWith(
        fontFamily: "Roboto Condensed",
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      ),
    ).apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    );
  }
}