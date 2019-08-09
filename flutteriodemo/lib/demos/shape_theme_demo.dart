import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShapeThemeDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShapeThemeDemoState();
}

class ShapeThemeDemoState extends State<ShapeThemeDemo> {
  bool _isCut = false;

  @override
  Widget build(BuildContext context) {
    ThemeData _roundTheme = Theme.of(context).copyWith(
        cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ));

    ThemeData _cutTheme = Theme.of(context).copyWith(
        cardTheme: CardTheme(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ));

    double _value = 0.5;

    return Theme(
      data: _isCut ? _cutTheme : _roundTheme,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Switch(
                value: _isCut,
                onChanged: (bool isCut) {
                  setState(() {
                    _isCut = isCut;
                  });
                },
              ),
              SizedBox(
                height: 100,
                child: Card(
                  child: Center(child: Text('Shape')),
                ),
              ),
              SizedBox(
                height: 100,
                child: Card(
                  child: Center(child: Text('Theme')),
                ),
              ),
              SliderTheme(
                data: Theme.of(context).sliderTheme.copyWith(
                  thumbShape: RoundSliderThumbShape()
                ),
                child: Slider(
                  value: _value,
                  onChanged: (double newValue) {
                    setState() {
                      _value = newValue;
                    }
                  },
                ),
              ),
              SliderTheme(
                data: Theme.of(context).sliderTheme.copyWith(
                    thumbShape: DiamondSliderThumbShape()
                ),
                child: Slider(
                  value: _value,
                  onChanged: (double newValue) {
                    setState() {
                      _value = newValue;
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DiamondSliderThumbShape extends RoundSliderThumbShape {
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    Path diamond = Path()
      ..moveTo(center.dx, center.dy - 8)
      ..relativeLineTo(8, 8)
      ..relativeLineTo(-8, 8)
      ..relativeLineTo(-8, -8)
      ..close();
    Paint paint = Paint()..color = sliderTheme.thumbColor;
    context.canvas.drawPath(diamond,paint);
//    context.canvas.restore();
  }
}