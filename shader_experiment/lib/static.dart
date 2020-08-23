import 'dart:ui';

import 'package:flutter/material.dart';

class StaticPinkDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: CustomPaint(
            painter: PinkSquarePainter(),
          ),
        ),
      ),
    );
  }
}

class PinkSquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = FragmentShader('''
        void main(float2 fragCoord, inout half4 fragColor) {
          fragColor = half4(1.0, 0, 1.0, 1.0);
        }
      '''),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}