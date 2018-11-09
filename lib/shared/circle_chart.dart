import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/constants.dart';
import 'package:rally_proto/formatters.dart';

class CircleChart extends StatefulWidget {
  CircleChart({this.centerLabel, this.centerAmount, this.total, this.amounts, this.colors});

  final String centerLabel;
  final double centerAmount;
  final double total;
  // TODO(clocksmith): Create ColoredAmount and use 1 list.
  final List<double> amounts;
  final List<Color> colors;

  _CircleChartState createState() => _CircleChartState();
}

class _CircleChartState extends State<CircleChart> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: Constants.defaultAnimationMillis * 3), vsync: this);
    animation = CurvedAnimation(parent: TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1.5),
    ]).animate(controller),
        curve: Curves.decelerate);
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return _AnimatedCircleChart(
      animation: animation,
      centerLabel: widget.centerLabel,
      centerAmount: widget.centerAmount,
      total: widget.total,
      amounts: widget.amounts,
      colors: widget.colors,
    );
  }
}

class _AnimatedCircleChart extends AnimatedWidget {
  _AnimatedCircleChart({Key key, this.animation, this.centerLabel, this.centerAmount, this.total, this.amounts, this.colors})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final String centerLabel;
  final double centerAmount;
  final double total;
  final List<double> amounts;
  final List<Color> colors;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return DecoratedBox(
      decoration: CircleChartOutlineDecoration(
        maxFraction: animation.value,
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
  CircleChartOutlineDecoration({this.maxFraction, this.total, this.amounts, this.colors});

  final double maxFraction;
  final double total;
  final List<double> amounts;
  final List<Color> colors;

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return _CircleChartOutlineBoxPainter(
      maxFraction: maxFraction,
      total: total,
      amounts: amounts,
      colors: colors,
    );
  }
}

class _CircleChartOutlineBoxPainter extends BoxPainter {
  _CircleChartOutlineBoxPainter({this.maxFraction, this.total, this.amounts, this.colors});

  final double maxFraction;
  final double total;
  final List<double> amounts;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    print('_CircleChartOutlineBoxPainter paint');
    // Create two padded rects to draw arcs in: one for colored arcs and one for inner bg arc.
    double strokeWidth = 4.0;
    double outerRadius = min(configuration.size.width, configuration.size.height) / 2;
    Rect outerRect = Rect.fromCircle(center: configuration.size.center(Offset.zero), radius: outerRadius - strokeWidth * 3);
    Rect innerRect = Rect.fromCircle(center: configuration.size.center(Offset.zero), radius: outerRadius - strokeWidth * 4);

    // Paint each arc with spacing
    double cummSum = 0;
    double wholeRad = (2 * pi);
    double spaceRad = wholeRad / 180;
    double wholeMinusSpacesRad = wholeRad - (amounts.length * spaceRad);
    for (int i = 0; i < amounts.length; i++) {
      Paint paint = Paint()..color = colors[i];
      double start = maxFraction * ((cummSum / total * wholeMinusSpacesRad) + spaceRad * i) - pi / 2;
      double sweep = maxFraction * (amounts[i] / total * wholeMinusSpacesRad);
      canvas.drawArc(outerRect, start, sweep, true, paint);
      cummSum += amounts[i];
    }

    // Paint any remaining space black (i.e. budget remianing amount).
    double left = total - cummSum;
    if (left > 0) {
      Paint paint = Paint()..color = Colors.black;
      double start = maxFraction * ((cummSum / total * wholeMinusSpacesRad) + spaceRad * amounts.length) - pi / 2;
      double sweep = maxFraction * (left / total * wholeMinusSpacesRad - spaceRad);
      canvas.drawArc(outerRect, start, sweep, true, paint);
    }

    // Paint a smaller inner curcle to cover the painted arcs to display as segments
    Paint bgPaint = Paint()..color = RallyColors.pageBg;
    canvas.drawArc(innerRect, 0, 2.0 * pi, true, bgPaint);
  }
}