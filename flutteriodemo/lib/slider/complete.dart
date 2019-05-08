import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

void main() {
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SliderDemo(),
  ));
}

class SliderDemo extends StatefulWidget {
  @override
  _SliderDemoState createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderTheme(
          data: SliderThemeData(
            trackHeight: 48,
            trackShape: _RainbowTriangularTrackShape(),
            thumbShape: _TriangularThumbShape(),
          ),
          child: Slider(
            value: _value,
            onChanged: (double newValue) {
              setState(() {
                _value = newValue;
              });
            },
          ),
        )
    );
  }
}

class _RainbowTriangularTrackShape extends RectangularSliderTrackShape {
  @override
  void paint(PaintingContext context, Offset offset,
      {RenderBox parentBox,
        SliderThemeData sliderTheme,
        Animation<double> enableAnimation,
        Offset thumbCenter,
        bool isEnabled = false,
        bool isDiscrete = false,
        TextDirection textDirection}) {
    final Rect trackRect = getPreferredRect(
        parentBox: parentBox,
        offset: offset,
        sliderTheme: sliderTheme,
        isEnabled: isEnabled,
        isDiscrete: isDiscrete);
    LinearGradient leftRainbowGradient = LinearGradient(colors: <Color>[
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple
    ]);

    LinearGradient rightGradient = LinearGradient(colors: <Color>[
      Colors.white,
      Colors.black,
      Colors.white,
    ]);

    final Rect leftTrackSegment = Rect.fromLTRB(
        trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom);
    Paint leftPaint = Paint()
      ..shader = leftRainbowGradient.createShader(leftTrackSegment);
    context.canvas.drawPath(_rightArrowTriangle(leftTrackSegment), leftPaint);
    final Rect rightTrackSegment = Rect.fromLTRB(
        thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom);
    Paint rightPaint = Paint()
      ..shader = rightGradient.createShader(rightTrackSegment);
    context.canvas.drawPath(_leftArrowTriangle(rightTrackSegment), rightPaint);
  }
}

class _TriangularThumbShape extends SliderComponentShape {
  static const double _thumbSize = 6.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
      PaintingContext context,
      Offset thumbCenter, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
      }) {
    final Canvas canvas = context.canvas;
    final double size = _thumbSize * sizeTween.evaluate(enableAnimation);
    final Path thumbPath = _triangle(size, thumbCenter);
    canvas.drawPath(thumbPath, Paint()..color = Colors.black);
    canvas.drawPath(
        thumbPath,
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke);
  }
}

Path _triangle(double size, Offset thumbCenter, {bool invert = false}) {
  final Path thumbPath = Path();
  final double height = sqrt(3.0) / 2.0;
  final double halfSide = size / 2.0;
  final double centerHeight = size * height / 3.0;
  final double sign = invert ? -1.0 : 1.0;
  thumbPath.moveTo(
      thumbCenter.dx - halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.lineTo(thumbCenter.dx, thumbCenter.dy - 2.0 * sign * centerHeight);
  thumbPath.lineTo(
      thumbCenter.dx + halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.close();
  return thumbPath;
}

Path _leftArrowTriangle(Rect rect) {
  final Path path = Path();
  path.moveTo(rect.left, rect.center.dy);
  path.lineTo(rect.right, rect.top);
  path.lineTo(rect.right, rect.bottom);
  path.close();
  return path;
}

Path _rightArrowTriangle(Rect rect) {
  final Path path = Path();
  path.moveTo(rect.right, rect.center.dy);
  path.lineTo(rect.left, rect.top);
  path.lineTo(rect.left, rect.bottom);
  path.close();
  return path;
}
