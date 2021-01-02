import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:theme_generator/constants.dart';
import 'package:google_fonts/google_fonts.dart';

// Fake locale to represent the system Locale option.
const systemLocaleOption = Locale('system');
const double systemTextScaleFactorOption = -1;

class ThemeOptions {
  const ThemeOptions({
    this.themeMode,
    this.primaryColor,
    this.secondaryColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    double textScaleFactor,
    this.platform,
    this.selectedScheme,
    this.lightThemeData,
    this.darkThemeData,
    this.textTheme,
    this.textStyle,
    this.textFontFamily,
  }) : _textScaleFactor = textScaleFactor;

  final ThemeMode themeMode;
  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final double _textScaleFactor;
  final TargetPlatform platform;
  final SelectedScheme selectedScheme;
  final ThemeData lightThemeData;
  final ThemeData darkThemeData;
  final TextTheme textTheme;
  final TextStyle textStyle;
  final String textFontFamily;

  // We use a sentinel value to indicate the system text scale option. By
  // default, return the actual text scale factor, otherwise return the
  // sentinel value.
  double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
    if (_textScaleFactor == systemTextScaleFactorOption) {
      return useSentinel
          ? systemTextScaleFactorOption
          : MediaQuery.of(context).textScaleFactor;
    } else {
      return _textScaleFactor;
    }
  }

  ThemeOptions copyWith({
    ThemeMode themeMode,
    Color primaryColor,
    Color secondaryColor,
    Color primaryTextColor,
    Color secondaryTextColor,
    double textScaleFactor,
    TargetPlatform platform,
    SelectedScheme selectedScheme,
    ThemeData lightThemeData,
    ThemeData darkThemeData,
    TextTheme textTheme,
    TextStyle textStyle,
    String textFontFamily,
  }) {
    return ThemeOptions(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      textScaleFactor: textScaleFactor ?? _textScaleFactor,
      platform: platform ?? this.platform,
      selectedScheme: selectedScheme ?? this.selectedScheme,
      lightThemeData: lightThemeData ?? this.lightThemeData,
      darkThemeData: darkThemeData ?? this.darkThemeData,
      textTheme: textTheme ?? this.textTheme,
      textStyle: textStyle ?? this.textStyle,
      textFontFamily: textFontFamily ?? this.textFontFamily,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ThemeOptions &&
      themeMode == other.themeMode &&
      primaryColor == other.primaryColor &&
      secondaryColor == other.secondaryColor &&
      primaryTextColor == other.primaryTextColor &&
      secondaryTextColor == other.secondaryTextColor &&
      _textScaleFactor == other._textScaleFactor &&
      platform == other.platform &&
      selectedScheme == other.selectedScheme &&
      lightThemeData == other.lightThemeData &&
      darkThemeData == other.darkThemeData &&
      textTheme == other.textTheme &&
      textStyle == other.textStyle &&
      textFontFamily == other.textFontFamily;

  @override
  int get hashCode => hashValues(
        themeMode,
        primaryColor,
        secondaryColor,
        primaryTextColor,
        secondaryTextColor,
        _textScaleFactor,
        platform,
        selectedScheme,
        lightThemeData,
        darkThemeData,
        textTheme,
        textStyle,
        textFontFamily,
      );

  static ThemeOptions of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, ThemeOptions newModel) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    scope.modelBindingState.updateModel(newModel);
  }

  /// Update ThemeData primary colors depending on the ThemeMode.
  ThemeOptions updatePrimaryColors(Color color, bool isActive) {
    if (this.themeMode == ThemeMode.light) {
      return copyWith(
        lightThemeData: (lightThemeData ?? ThemeData()).copyWith(
          primaryColor: color,
        ),
        primaryColor: color,
        primaryTextColor: isActive
            ? Colors.black
            : color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      );
    } else {
      return copyWith(
        darkThemeData: (darkThemeData ?? ThemeData()).copyWith(
          primaryColor: color,
        ),
        primaryColor: color,
        primaryTextColor: isActive
            ? Colors.black
            : color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      );
    }
  }

  ThemeData removePrimaryColors() {
    if (this.themeMode == ThemeMode.light) {
      return lightThemeData.copyWith(
        primaryColor: null,
      );
    } else {
      return darkThemeData.copyWith(
        primaryColor: null,
      );
    }
  }

  /// Update secondary colors depending on ThemeMode.
  ThemeOptions updateSecondaryColors(Color color, bool isActive) {
    if (this.themeMode == ThemeMode.light) {
      return copyWith(
        lightThemeData: (lightThemeData ?? ThemeData()).copyWith(
          colorScheme: (lightThemeData?.colorScheme ?? ColorScheme.light())
              .copyWith(secondary: color),
        ),
        secondaryColor: color,
        secondaryTextColor: isActive
            ? Colors.black
            : color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      );
    } else {
      return copyWith(
        darkThemeData: (darkThemeData ?? ThemeData()).copyWith(
          colorScheme: (lightThemeData?.colorScheme ?? ColorScheme.dark())
              .copyWith(secondary: color),
        ),
        secondaryColor: color,
        secondaryTextColor: isActive
            ? Colors.black
            : color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
      );
    }
  }

  ThemeData removeSecondaryColors() {
    if (this.themeMode == ThemeMode.light) {
      return lightThemeData.copyWith(
        colorScheme: lightThemeData.colorScheme.copyWith(
          secondary: null,
        ),
      );
    } else {
      return darkThemeData.copyWith(
        colorScheme: darkThemeData.colorScheme.copyWith(
          secondary: null,
        ),
      );
    }
  }

  ThemeOptions setSelectedSchemeColorToNull() {
    return ThemeOptions(
      themeMode: this.themeMode,
      primaryColor: selectedScheme == SelectedScheme.PrimaryColor
          ? null
          : this.primaryColor,
      secondaryColor: selectedScheme == SelectedScheme.SecondaryColor
          ? null
          : this.secondaryColor,
      primaryTextColor: selectedScheme == SelectedScheme.PrimaryText
          ? null
          : this.primaryTextColor,
      secondaryTextColor: selectedScheme == SelectedScheme.SecondaryText
          ? null
          : this.secondaryTextColor,
      textScaleFactor: _textScaleFactor,
      platform: this.platform,
      selectedScheme: this.selectedScheme,
      lightThemeData: () {
        switch (selectedScheme) {
          case SelectedScheme.PrimaryColor:
            removePrimaryColors();
            break;
          case SelectedScheme.SecondaryColor:
            removeSecondaryColors();
            break;
          case SelectedScheme.PrimaryText:
            // TODO: Handle this case.
            break;
          case SelectedScheme.SecondaryText:
            // TODO: Handle this case.
            break;
        }
      }(),
      darkThemeData: this.darkThemeData,
      textTheme: this.textTheme,
      textStyle: this.textStyle,
    );
  }

  void toggleThemeMode(BuildContext context) {
    if (themeMode == ThemeMode.light) {
      update(context,
          ThemeOptions.of(context).copyWith(themeMode: ThemeMode.dark));
    } else if (themeMode == ThemeMode.dark) {
      update(context,
          ThemeOptions.of(context).copyWith(themeMode: ThemeMode.light));
    } else {
      update(context,
          ThemeOptions.of(context).copyWith(themeMode: ThemeMode.dark));
    }
  }

  @override
  String toString() {
    return """
    import \'package:flutter/material.dart\';
    import \'package:google_fonts/google_fonts.dart\';
    
    class AppThemeData {
    ${() {
      String themeDataString = '';
      if (lightThemeData != null) {
        themeDataString +=
            '  static ThemeData lightThemeData = themeData(_lightColorScheme);\n';
      }
      if (darkThemeData != null) {
        themeDataString +=
            '  static ThemeData lightThemeData = themeData(_darkColorScheme);\n';
      }
      return themeDataString;
    }()}
  
      static ThemeData themeData(ColorScheme colorScheme) {
        return ThemeData(
          colorScheme: colorScheme,
          textTheme: _textTheme,
        );
      }
      
      ${colorSchemeAsString(lightThemeData?.colorScheme, '_lightColorScheme')}
      ${colorSchemeAsString(darkThemeData?.colorScheme, '_darkColorScheme')}
      $textThemeAsString
    }  
""";
  }

  /// Check if it it possible to do a reverse lookup with GoogleFonts.
  ///For example: textTheme =  TextTheme(
  //.headline1: GoogleFonts.roboto(),
  ///);
  ///
  ///When I run textTheme.toString I get
  //.TextStyle(inherit: true, family: Roboto_regular, familyback: [Roboto]),
  String get textThemeAsString {
    if (textTheme == null) return '';

    String textThemeString = 'static TextTheme _textTheme = TextTheme(\n';

    if (textTheme?.headline1 != null)
      textThemeString +=
          '        headline1: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.headline2 != null)
      textThemeString +=
          '        headline2: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.headline3 != null)
      textThemeString +=
          '        headline3: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.headline4 != null)
      textThemeString +=
          '        headline4: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.headline5 != null)
      textThemeString +=
          '        headline5: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.headline6 != null)
      textThemeString +=
          '        headline6: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.subtitle1 != null)
      textThemeString +=
          '        subtitle1: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.subtitle2 != null)
      textThemeString +=
          '        subtitle2: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.bodyText1 != null)
      textThemeString +=
          '        bodyText1: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.bodyText2 != null)
      textThemeString +=
          '        bodyText2: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.caption != null)
      textThemeString +=
          '        caption: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.button != null)
      textThemeString +=
          '        button: GoogleFonts.getFont(\'$textFontFamily\'),\n';
    if (textTheme?.overline != null)
      textThemeString +=
          '        overline: GoogleFonts.getFont(\'$textFontFamily\'),\n';

    textThemeString += '      );\n';

    return textThemeString;
  }

  String colorSchemeAsString(ColorScheme colorScheme, String colorSchemeName) {
    if (colorScheme == null) return '';

    String colorSchemeString =
        'static ColorScheme $colorSchemeName = ColorScheme(\n';

    if (colorScheme?.primary != null) {
      colorSchemeString += '        primary: const ${colorScheme.primary},\n';
    }
    if (colorScheme?.primaryVariant != null) {
      colorSchemeString +=
          '        primaryVariant: const ${colorScheme.primaryVariant},\n';
    }
    if (colorScheme?.secondary != null) {
      colorSchemeString +=
          '        secondary: const ${colorScheme.secondary},\n';
    }
    if (colorScheme?.secondaryVariant != null) {
      colorSchemeString +=
          '        secondaryVariant: const ${colorScheme.secondaryVariant},\n';
    }
    if (colorScheme?.background != null) {
      colorSchemeString +=
          '        background: const ${colorScheme.background},\n';
    }
    if (colorScheme?.surface != null) {
      colorSchemeString += '        surface: const ${colorScheme.surface},\n';
    }
    if (colorScheme?.error != null) {
      colorSchemeString += '        error: const ${colorScheme.error},\n';
    }
    if (colorScheme?.onPrimary != null) {
      colorSchemeString +=
          '        onPrimary: const ${colorScheme.onPrimary},\n';
    }
    if (colorScheme?.onSecondary != null) {
      colorSchemeString +=
          '        onSecondary: const ${colorScheme.onSecondary},\n';
    }
    if (colorScheme?.onBackground != null) {
      colorSchemeString +=
          '        onBackground: const ${colorScheme.onBackground},\n';
    }
    if (colorScheme?.onSurface != null) {
      colorSchemeString +=
          '        onSurface: const ${colorScheme.onSurface},\n';
    }
    if (colorScheme?.onError != null) {
      colorSchemeString += '        onError: const ${colorScheme.onError},\n';
    }
    if (colorScheme?.brightness != null) {
      colorSchemeString += '        brightness: ${colorScheme.brightness},\n';
    }
    colorSchemeString += '      );\n';

    return colorSchemeString;
  }
}

// See https://medium.com/flutter/managing-flutter-application-state-with-inheritedwidgets-1140452befe1
class _ModelBindingScope extends InheritedWidget {
  _ModelBindingScope({
    Key key,
    @required this.modelBindingState,
    Widget child,
  })  : assert(modelBindingState != null),
        super(key: key, child: child);

  final _ModelBindingState modelBindingState;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  ModelBinding({
    Key key,
    this.initialModel = const ThemeOptions(),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);

  final ThemeOptions initialModel;
  final Widget child;

  @override
  _ModelBindingState createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  ThemeOptions currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleThemeChange(ThemeOptions newModel) {
    switch (newModel.themeMode) {
      case ThemeMode.system:
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        SystemChrome.setSystemUIOverlayStyle(brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);
        break;
      case ThemeMode.light:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        break;
      case ThemeMode.dark:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }
  }

  void updateModel(ThemeOptions newModel) {
    if (newModel != currentModel) {
      handleThemeChange(newModel);
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}
