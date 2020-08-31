// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:shaderexperiment/demos/ui.dart';

import 'demos/animated.dart';
import 'demos/image.dart';
import 'demos/static.dart';

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

class AllDemos extends StatefulWidget {
  @override
  _AllDemosState createState() => _AllDemosState();
}

class _AllDemosState extends State<AllDemos> {
  final List<bool> _expanded = [false, false, false];

  final List<_DemoCategory> _categories = [
    _DemoCategory(
      title: 'Static',
      children: [
        _DemoTitle(
          title: 'Pink',
          builder: (context) => StaticPinkDemo(),
        ),
      ],
      isExpanded: false,
    ),
    _DemoCategory(
      title: 'Animated',
      children: [
        _DemoTitle(
          title: 'Color Change',
          builder: (context) => AnimatedSolidColorDemo(),
        ),
        _DemoTitle(
          title: 'Spiral',
          builder: (context) => AnimatedSpiral(),
        ),
        _DemoTitle(
          title: 'Image Upload Wave',
          builder: (context) => UploadImageAnimationDemo(),
        ),
        _DemoTitle(
          title: 'Image Upload Pulse',
          builder: (context) => UploadImageAnimationDemo2(),
        ),
      ],
      isExpanded: false,
    ),
    _DemoCategory(
      title: 'UI Demos',
      children: [
        _DemoTitle(
          title: 'Image Sending Demo',
          builder: (context) => ImageSendDemo(),
        ),
      ],
      isExpanded: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _categories[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: [
                for (final category in _categories)
                  ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(title: Text(category.title));
                    },
                    body: Column(
                      children: category.children,
                    ),
                    isExpanded: category.isExpanded,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoCategory {
  final String title;
  final List<Widget> children;
  bool isExpanded;

  _DemoCategory({
    this.title,
    this.children,
    this.isExpanded = false,
  });
}

class _DemoTitle extends StatelessWidget {
  _DemoTitle({this.title, this.builder});

  final String title;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: builder));
      },
      child: ListTile(
        title: Text(title),
      ),
    );
  }
}
