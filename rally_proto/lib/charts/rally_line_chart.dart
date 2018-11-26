import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/financial_entity/financial_entity.dart';
import 'package:rally_proto/util/colors.dart';

class RallyLineChart extends StatelessWidget {
  RallyLineChart({this.events});

  final List<DetailedEventItem> events;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: RallyLineChartPainter(context, events)
    );
  }
}

class RallyLineChartPainter extends CustomPainter {
  RallyLineChartPainter(this.context, this.events);

  final BuildContext context;
  final List<DetailedEventItem> events;

  final double space = 16.0;
  final int numDays = 52;
  final int shift = 3;

  @override
  void paint(Canvas canvas, Size size) {
    _drawXAxisLabels(canvas, size);
    _drawXAxisTicks(canvas, size.width, size.height - space);
    _drawLine(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  _drawXAxisLabels(Canvas canvas, Size size) {
    TextPainter leftLabel = TextPainter(
      text: TextSpan(
          text: 'DEC 2018',
          style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.w700, color: RallyColors.gray25a)
      ),
      textDirection: TextDirection.ltr,
    );
    leftLabel.layout();
    leftLabel.paint(canvas, Offset(0.0 + space / 2, size.height - leftLabel.height - space));

    TextPainter centerLabel = TextPainter(
      text: TextSpan(
          text: 'JAN 2019',
          style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.w700)
      ),
      textDirection: TextDirection.ltr,
    );
    centerLabel.layout();
    centerLabel.paint(canvas, Offset((size.width - centerLabel.width) / 2, size.height - centerLabel.height - space));

    TextPainter rightLabel = TextPainter(
      text: TextSpan(
          text: 'FEB 2018',
          style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.w700, color: RallyColors.gray25a)
      ),
      textDirection: TextDirection.ltr,
    );
    rightLabel.layout();
    rightLabel.paint(canvas, Offset(size.width - centerLabel.width - space / 2, size.height - rightLabel.height - space));
  }

  _drawXAxisTicks(Canvas canvas, double width, double bottomOffset) {
    double top = bottomOffset - space * 3.5;
    double weekTop = bottomOffset - space * 5.0;
    double bottom = bottomOffset - space * 2;
    for (int i = 0; i < numDays; i++) {
      double x =  width / numDays * i;
      canvas.drawRect(
          new Rect.fromPoints(Offset(x, i % 7 == shift ? weekTop : top), Offset(x, bottom)),
          new Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0
            ..color = RallyColors.gray25a
      );
    }
  }

  _drawLine(Canvas canvas, Size sizgie) {
    Paint linePaint = Paint()
      ..color = RallyColors.getAccountColor(1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // The top left of the window is at 0,0, so these are the same as right and bottom.
    double windowWidth = size.width;
    double windowHeight = size.height - space * 5.0;

    // Ranges uses to lerp the pixel points.
    int windowMillis = numDays * 24 * 60 * 60 * 1000;
    double maxAmount = 2000.0; // minAmount is 0.0

    // Beginning of window. The end is this plus numDays.
    DateTime startDate = DateTime.utc(2018, 12, 1);

    // Arbitrary value for the first point. In a real app, a wider range of
    // points would be used that go beyond the boudnaries of the screen.
    double lastAmount = 800.0;

    // Create a list of points in terms of pixels from top left.
    // TODO(clocksmith): Align the points for smooth curves.
    final List<Offset> points = [Offset(0, (maxAmount - lastAmount) / maxAmount * windowHeight)];
    points.addAll(events.reversed.map((event) {
      lastAmount += event.amount;
      int diffMiliis = event.date.millisecondsSinceEpoch - startDate.millisecondsSinceEpoch;
      double x = diffMiliis / windowMillis * windowWidth;
      double y = (maxAmount - lastAmount) / maxAmount * windowHeight;
      return Offset(x, y);
    }));

    final Path path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 2; i < points.length; i++) {
      path.cubicTo(points[i - 2].dx, points[i - 2].dy, points[i - 1].dx, points[i - 1].dy, points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);
  }
}