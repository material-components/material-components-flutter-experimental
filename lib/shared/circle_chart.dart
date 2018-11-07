import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CircleChart extends StatelessWidget {
  CircleChart({this.total, this.amounts, this.colors});

  final double total;
  final List<double> amounts;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        height: 237.0,
        child: Center(
            child: Text('circle chart')
        )
    );
  }
}

class CircleChartOutline extends RenderConstrainedBox {
  @override
  void paint(PaintingContext context, Offset offset) {
//    Paint p = Paint(context)
  }

}