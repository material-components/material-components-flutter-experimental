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
      home: RallyHomePage(title: 'Rally Home Page'),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }

  ThemeData _buildRallyTheme() {
    final ThemeData base = ThemeData.dark();
    return ThemeData(
      scaffoldBackgroundColor: Color(0xFF33333D),
      primarySwatch: RallyColors.primaryGreen,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xFF26282F)
      ),
//      accentColor: kShrineBrown900,
//      primaryColor: kShrinePink100,
//      buttonColor: kShrinePink100,
//      scaffoldBackgroundColor: kShrineBackgroundWhite,
//      cardColor: kShrineBackgroundWhite,
//      textSelectionColor: kShrinePink100,
//      errorColor: kShrineErrorRed,
//      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
//      primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
//      inputDecorationTheme: InputDecorationTheme(border: CutCornersBorder()),
//      textTheme: _buildShrineTextTheme(base.textTheme),
//      primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//      accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//      iconTheme: _customIconTheme(base.iconTheme),
    );
  }
}