import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../anypixel.dart';

class AnypixelBannerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnypixelBridge(
      child: Container(
        color: Colors.black,
        child: Image.asset('assets/rally3.png'),
      ),
      onPressed: (Offset offset) {
        print(offset.toString());
      },
    );
  }
}