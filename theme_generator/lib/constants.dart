import 'package:flutter/foundation.dart' show describeEnum;

enum SelectedScheme {
  PrimaryColor,
  SecondaryColor,
  PrimaryText,
  SecondaryText,
}

extension SelectedSchemeExtension on SelectedScheme {
  String get name => describeEnum(this);

  String displayTitle() {
    switch (this) {
      case SelectedScheme.PrimaryColor:
        return 'Primary';
      case SelectedScheme.SecondaryColor:
        return 'Secondary';
      case SelectedScheme.PrimaryText:
        return 'Text of P';
      case SelectedScheme.SecondaryText:
        return 'Text on S';
      default:
        return 'SelectedScheme Title is null';
    }
  }

  String displayLightColorText() {
    switch (this) {
      case SelectedScheme.PrimaryColor:
        return 'P - Light\n';
      case SelectedScheme.SecondaryColor:
        return 'S - Light\n';
      case SelectedScheme.PrimaryText:
        return 'PT - Light\n';
      case SelectedScheme.SecondaryText:
        return 'PT - Light\n';
      default:
        return 'SelectedScheme Light is null';
    }
  }

  String displayDarkColorText() {
    switch (this) {
      case SelectedScheme.PrimaryColor:
        return 'P - Dark\n';
      case SelectedScheme.SecondaryColor:
        return 'S - Dark\n';
      case SelectedScheme.PrimaryText:
        return 'PT - Dark\n';
      case SelectedScheme.SecondaryText:
        return 'PT - Dark\n';
      default:
        return 'SelectedScheme Dark is null';
    }
  }
}
