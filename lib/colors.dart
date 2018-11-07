import 'package:flutter/material.dart';

class RallyColors {
  static const MaterialColor primaryGreen = MaterialColor(
    _primaryGreenPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(_primaryGreenPrimaryValue),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );
  static const int _primaryGreenPrimaryValue = 0xFFF44336;

  static const List<Color> accountColors = <Color>[
    Color(0xFF005D57),
    Color(0xFF04B97F),
    Color(0xFF37EFBA),
    Color(0xFF007D51),
  ];

  static const List<Color> billColors = <Color>[
    Color(0xFFFFDC78),
    Color(0xFFFF6951),
    Color(0xFFFFD7D0),
    Color(0xFFFFAC12),
  ];

  static const List<Color> budgetColors = <Color>[
    Color(0xFFB2F2FF),
    Color(0xFFB15DFF),
    Color(0xFF72DEFF),
    Color(0xFF0082FB),
  ];

  static Color getAccountColor(int i) {
    return accountColors[i % accountColors.length];
  }

  static Color getBillColor(int i) {
    return billColors[i % billColors.length];
  }

  static Color getBudgetColor(int i) {
    return budgetColors[i % budgetColors.length];
  }

  static Color gray60 = Color(0x99D8D8D8);
  static Color gray = Color(0xFFD8D8D8);
}