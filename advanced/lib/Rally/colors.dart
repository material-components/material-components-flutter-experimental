import 'package:flutter/material.dart';

/// Most color assignments in Rally are not like the the typical color
/// assignments that are common in other apps. Instead of primarily mapping to
/// component type and part, they are assigned round robin based on layout.
class RallyColors {
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

  // TODO(clocksmith): Use color scheme where possible

  static Color gray = Color(0xFFD8D8D8);
  static Color gray60a = Color(0x99D8D8D8);

  static Color pageBg = Color(0xFF33333D);
  static Color inputBg = Color(0xFF26282F);
}