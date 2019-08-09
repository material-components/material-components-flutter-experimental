import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/demos/bottom_nav_demo.dart';
import 'package:material_flutter_io19/demos/extended_fab_demo.dart';
import 'package:material_flutter_io19/demos/radical_slider_demo.dart';
import 'package:material_flutter_io19/demos/shape_theme_demo.dart';
import 'package:material_flutter_io19/demos/text_field_demo.dart';

import 'demos/adaptive_controls_demo.dart';
import 'demos/search_demo.dart';

class IoDemo {
  const IoDemo({
    @required this.title,
    @required this.routeBuilder,
  })  : assert(title != null),
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
    ];
  }
}
