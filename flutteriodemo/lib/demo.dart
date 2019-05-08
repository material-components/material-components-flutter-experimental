import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/demos/bottom_nav_demo.dart';
import 'package:material_flutter_io19/demos/extended_fab_demo.dart';
import 'package:material_flutter_io19/demos/radical_slider_demo.dart';
import 'package:material_flutter_io19/demos/shape_theme_demo.dart';
import 'package:material_flutter_io19/demos/anypixel_starter_demo.dart';
import 'package:material_flutter_io19/demos/text_field_demo.dart';

import 'demos/adaptive_controls_demo.dart';
import 'demos/anypixel_banner_demo.dart';
import 'demos/anypixel_fortnightly_demo.dart';
import 'demos/anypixel_height_demo.dart';
import 'demos/anypixel_life_demo.dart';
import 'demos/search_demo.dart';

class IoDemo {
  const IoDemo({
    @required this.title,
    @required this.routeBuilder,
  }) : assert(title != null),
      assert(routeBuilder != null);

  final String title;
  final WidgetBuilder routeBuilder;

  @override
  String toString() {
    return '$runtimeType($title)';
  }
}

class IoDemos {
  static List<IoDemo> buildDemos() {
    return [
      IoDemo(
        title: 'test',
        routeBuilder: (BuildContext context) => const Text('hi test'),
      ),
      IoDemo(
        title: 'Shape Theme',
        routeBuilder: (BuildContext context) => ShapeThemeDemo(),
      ),
      IoDemo(
        title: 'Radical Slider',
        routeBuilder: (BuildContext context) => RadicalSliderDemo(),
      ),
      IoDemo(
        title: 'Text Field',
        routeBuilder: (BuildContext context) => TextFieldDemo(),
      ),
      IoDemo(
        title: 'Bottom Nav',
        routeBuilder: (BuildContext context) => BottomNavDemo(),
      ),
      IoDemo(
        title: 'Extended Fab',
        routeBuilder: (BuildContext context) => ExtendedFabDemo(),
      ),
      IoDemo(
        title: 'Search',
        routeBuilder: (BuildContext context) => SearchDemo(),
      ),
      IoDemo(
        title: "Adaptive Controls",
        routeBuilder: (BuildContext context) => AdaptiveControlsDemo(),
      )
//      IoDemo(
//        title: 'Anypixel Starter',
//        routeBuilder: (BuildContext context) => AnypixelStarterDemo(),
//      ),
//      IoDemo(
//        title: 'Anypixel Fortnightly',
//        routeBuilder: (BuildContext context) => AnypixelFortnightlyDemo(),
//      ),
//      IoDemo(
//        title: 'Anypixel Banner',
//        routeBuilder: (BuildContext context) => AnypixelBannerDemo(),
//      ),
//      IoDemo(
//        title: 'Anypixel Life',
//        routeBuilder: (BuildContext context) => AnypixelLifeDemo(),
//      ),
//      IoDemo(
//        title: 'Anypixel Height',
//        routeBuilder: (BuildContext context) => AnypixelHeightDemo(),
//      ),
//      IoDemo(
//        title: 'Fortnightly Phone Portrait',
//        routeBuilder: (BuildContext context) => FortnightlyPhonePortrait(),
//      ),
    ];
  }
}
