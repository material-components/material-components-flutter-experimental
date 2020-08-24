import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:shaderexperiment/static.dart';

import 'animated.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fragment Shaders Demo',
      home: AllDemos(),
    );
  }
}

class AllDemos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            _DemoTitle(
              title: 'Static Color',
              route: MaterialPageRoute(
                builder: (context) => StaticPinkDemo(),
              ),
            ),
            _DemoTitle(
              title: 'Animated Color Change',
              route: MaterialPageRoute(
                builder: (context) => AnimatedSolidColorDemo(),
              ),
            ),
            _DemoTitle(
              title: 'Animated Spiral',
              route: MaterialPageRoute(
                builder: (context) => AnimatedSpiral(),
              ),
            ),
//            _DemoTitle(
//              title: 'Animated Protean Clouds',
//              route: MaterialPageRoute(
//                builder: (context) => ProteanClouds(),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}

class _DemoTitle extends StatelessWidget {
  _DemoTitle({this.title, this.route});

  final String title;
  final MaterialPageRoute route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FlatButton(
        child: Text(title),
        onPressed: () {
          Navigator.push(context, route);
        },
      ),
    );
  }
}
