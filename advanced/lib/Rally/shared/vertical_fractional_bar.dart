import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerticalFractionalBar extends StatelessWidget {
  VerticalFractionalBar({this.color, this.fraction});

  final Color color;
  final double fraction;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        height: 32.0,
        width: 4.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (1 - fraction) * 32.0,
              child: Container(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: fraction * 32.0,
              child: Container(
                color: color
              ),
            ),
          ]
        )
    );
  }
}