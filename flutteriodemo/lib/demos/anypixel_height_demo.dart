import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../anypixel.dart';

class AnypixelHeightDemo extends StatefulWidget {
  @override
  AnypixelHeightDemoState createState() => AnypixelHeightDemoState();
}

class AnypixelHeightDemoState extends State<AnypixelHeightDemo> {
  double containerHeight = 0;
  double x = 0;
  double y = 42;
  double opacity = 0;

  _handlePressed(Offset offset) {
    setState(() {
      x = offset.dx;
      y = offset.dy;
      opacity = 1;
    });
  }

  @override
  void initState() {
    super.initState();
//    _handlePressed(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    double left = x;
    double right = 140 - x - 1;
    double top = y;
    double textRight = 140 - x - 30;
    int heightInches = 19 + 2 * (42 - y.round());
    String heightText = '${heightInches ~/ 12}\'${heightInches % 12}"';

    return AnypixelBridge(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.only(left: left, top: top, right: right),
              color: Colors.green,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.only(left: left + 2, top: max(0, top - 10) , right: textRight),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  heightText,
                  style: Theme.of(context).textTheme.headline.copyWith(
                        fontSize: 9,
                        color: Colors.white,
                        letterSpacing: 0.9,
                        fontWeight: FontWeight.w500,
//                    decoration: TextDecoration.underline,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      onPressed: _handlePressed,
    );
  }
}
