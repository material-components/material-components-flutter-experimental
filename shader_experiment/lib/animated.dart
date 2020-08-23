import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimatedSolidColorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: TickingFragmentShader(
            sksl: '''
              uniform float t;
            
              void main(float2 xy, inout half4 color) {
                color = half4(half(sin(t / 1000.0)), 0.0, 1.0, 1.0);
              }
            ''',
          ),
        ),
      ),
    );
  }
}

class TickingFragmentShader extends StatefulWidget {
  TickingFragmentShader({this.sksl});

  final String sksl;

  @override
  _TickingFragmentShaderState createState() => _TickingFragmentShaderState();
}

class _TickingFragmentShaderState extends State<TickingFragmentShader> {
  double _time; // millis

  @override
  void initState() {
    super.initState();
    Ticker((duration) {
      setState(() {
        _time = duration.inMicroseconds / 1000.0;
      });
    }).start();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomPainterWithTime(sksl: widget.sksl, time: _time),
    );
  }
}

class CustomPainterWithTime extends CustomPainter {
  CustomPainterWithTime({this.sksl, this.time})
      : _shader = FragmentShader(sksl);

  final String sksl;
  final double time;
  final FragmentShader _shader;

  @override
  void paint(Canvas canvas, Size size) {
    _shader.setTime(time);
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = _shader,
    );
  }

  @override
  bool shouldRepaint(CustomPainterWithTime oldDelegate) {
    return oldDelegate.time != time;
  }
}