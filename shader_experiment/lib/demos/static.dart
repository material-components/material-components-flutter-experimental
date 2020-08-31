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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shaderexperiment/api.dart';

class StaticPinkDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderDemo(
      sksl: _sksl,
      builder: (context) {
        return CustomPaint(
          painter: PinkSquarePainter(_sksl),
        );
      },
    );
  }
}

class PinkSquarePainter extends CustomPainter {
  final String sksl;

  PinkSquarePainter(this.sksl);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = FragmentShader(sksl),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

const _sksl = '''
  void main(float2 xy, inout half4 color) {
    color = half4(1.0, 0, 1.0, 1.0);
  }
''';