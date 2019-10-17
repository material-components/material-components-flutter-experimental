import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData kCraneTheme = _buildCraneTheme();

IconThemeData _customIconTheme(IconThemeData original, Color color) {
  return original.copyWith(color: color);
}

ThemeData _buildCraneTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    colorScheme: ColorScheme.light().copyWith(
      primary: kCranePurple800,
      secondary: kCraneRed700,
    ),
    accentColor: kCranePurple700,
    primaryColor: kCranePurple800,
    buttonColor: kCraneRed700,
    hintColor: kCraneWhite60,
    indicatorColor: kCranePrimaryWhite,
    scaffoldBackgroundColor: kCranePrimaryWhite,
    cardColor: kCranePrimaryWhite,
    textSelectionColor: kCranePurple700,
    errorColor: kCraneErrorOrange,
    highlightColor: Colors.transparent,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
    textTheme: _buildCraneTextTheme(base.textTheme),
    primaryTextTheme: _buildCraneTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildCraneTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme, kCraneWhite60),
    primaryIconTheme: _customIconTheme(base.iconTheme, kCranePrimaryWhite),
  );
}

TextTheme _buildCraneTextTheme(TextTheme base) {
  return base
      .copyWith(
        display4: base.display4.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 96.0,
        ),
        display3: base.display3.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 60.0,
        ),
        display2: base.display2.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 48.0,
        ),
        display1: base.display1.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 34.0,
        ),
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 24.0,
        ),
        title: base.title.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
        subhead: base.subhead.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          letterSpacing: 0.5,
        ),
        subtitle: base.subtitle.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
          color: kCraneGrey,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        body1: base.body1.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 13.0,
          letterSpacing: 0.8,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
          color: kCraneGrey,
        ),
        overline: base.overline.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
        ),
      )
      .apply(
        fontFamily: 'Raleway',
      );
}
