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

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class TickingFragmentShader extends StatefulWidget {
  TickingFragmentShader({this.sksl, this.image});

  final String sksl;
  final ui.Image image;

  @override
  _TickingFragmentShaderState createState() => _TickingFragmentShaderState();
}

class _TickingFragmentShaderState extends State<TickingFragmentShader> {
  double _time; // seconds
  ui.FragmentShader _shader;
  Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _shader = ui.FragmentShader(widget.sksl);
    if (widget.image != null) {
      _shader.setImage(
        widget.image,
        TileMode.clamp,
        TileMode.clamp,
        Matrix4.identity().storage,
      );
    }
    _ticker = Ticker((duration) {
      setState(() {
        _time = duration.inMicroseconds / 1000.0 / 1000.0;
      });
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomPainterWithTime(shader: _shader, time: _time),
    );
  }
}

class CustomPainterWithTime extends CustomPainter {
  CustomPainterWithTime({this.shader, this.time});

  final ui.FragmentShader shader;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader.setTime(time);
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(CustomPainterWithTime oldDelegate) {
    return oldDelegate.time != time;
  }
}

Future<ui.Image> loadUiImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}
