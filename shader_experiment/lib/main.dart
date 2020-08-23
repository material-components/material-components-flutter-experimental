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
            SizedBox(
              height: 100,
              child: FlatButton(
                child: Text('StaticPinkDemo'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StaticPinkDemo();
                  }));
                },
              ),
            ),
            SizedBox(
              height: 100,
              child: FlatButton(
                child: Text('ShaderDemo2'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AnimatedSolidColorDemo();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}