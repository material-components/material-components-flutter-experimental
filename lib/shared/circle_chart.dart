import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/formatters.dart';

class CircleChart extends StatelessWidget {
  CircleChart({this.centerLabel, this.centerAmount, this.total, this.amounts, this.colors});

  final String centerLabel;
  final double centerAmount;
  final double total;
  final List<double> amounts;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DecoratedBox(
      decoration: CircleChartOutlineDecoration(
        total: total,
        amounts: amounts,
        colors: colors,
      ),
      child: SizedBox(
          height: 237.0,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Text(centerLabel),
                Text(Formatters.usdWithSign.format(centerAmount),
                    style: Theme.of(context).textTheme.body2.copyWith(fontSize: 32.0)),
          ])
          )
      ),
    );
  }
}

class CircleChartOutlineDecoration extends Decoration {
  CircleChartOutlineDecoration({this.total, this.amounts, this.colors});

  final double total;
  final List<double> amounts;
  final List<Color> colors;
  
  @override
  BoxPainter createBoxPainter([onChanged]) {
    return _CircleChartOutlineBoxPainter(
      total: total,
      amounts: amounts,
      colors: colors,
    );
  }
}

class _CircleChartOutlineBoxPainter extends BoxPainter {
  _CircleChartOutlineBoxPainter({this.total, this.amounts, this.colors});

  final double total;
  final List<double> amounts;
  final List<Color> colors;
  
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    double strokeWidth = 4.0;
    double outerRadius = min(configuration.size.width, configuration.size.height) / 2;
    Rect outerRect = Rect.fromCircle(center: configuration.size.center(Offset.zero), radius: outerRadius);
    Rect innerRect = Rect.fromCircle(center: configuration.size.center(Offset.zero), radius: outerRadius - strokeWidth);

    double cummSum = 0;
    double wholeRad = (2 * pi);
    double spaceRad = pi / 100;
    double wholeMinusSpacesRad = wholeRad - (amounts.length * spaceRad);
    for (int i = 0; i < amounts.length; i++) {
      Paint paint = Paint()..color = colors[i];
      double start = (cummSum / total * wholeMinusSpacesRad - pi / 2) + spaceRad * i;
      double sweep = amounts[i] / total * wholeMinusSpacesRad;
      canvas.drawArc(outerRect, start, sweep, true, paint);
      cummSum += amounts[i];
    }

    double left = total - cummSum;
    if (left > 0) {
      Paint paint = Paint()..color = Colors.black;
      double start = (cummSum / total * wholeMinusSpacesRad - pi / 2) + spaceRad * amounts.length;
      double sweep = left / total * wholeMinusSpacesRad - spaceRad;
      canvas.drawArc(outerRect, start, sweep, true, paint);
    }

    Paint bgPaint = Paint()..color = RallyColors.bgColor;
    canvas.drawArc(innerRect, 0, 2.0 * pi, true, bgPaint);

//    final Paint paint = Paint();
//    print(configuration.size);
//    final center = configuration.size.center(Offset.zero);
//    paint.color = Colors.greenAccent;
//    canvas.drawCircle(center, 25.0, paint);
  }
}