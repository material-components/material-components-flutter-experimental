// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_flutter_io19/demo.dart';
import 'package:material_flutter_io19/home.dart';

class IoApp extends StatefulWidget {
  @override
  _IoAppState createState() => _IoAppState();
}

class _IoAppState extends State<IoApp> {
  Map<String, WidgetBuilder> _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      IoDemos.buildDemos(),
      key: (dynamic demo) => '${demo.title}',
      value: (dynamic demo) => demo.routeBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demos',
      home: IoHome(),
      routes: _buildRoutes(),
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(primaryColor: Color(0xFF6200EE)),
    );
  }
}