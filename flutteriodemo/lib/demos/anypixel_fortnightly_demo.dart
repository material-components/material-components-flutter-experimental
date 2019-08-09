import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../anypixel.dart';

class AnypixelFortnightlyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .primaryTextTheme
        .headline
        .copyWith(fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.w500);
    List<Widget> children = [
      SizedBox(
        width: 140,
        child: Center(
          child: Image.asset('assets/fortlogo_140x42.png'),
        ),
      ),
      SizedBox(
        width: 140,
        child: Center(
          child: Text(
            'The Quiet, Yet Powerful Healthcare Revolution',
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        width: 140,
        child: Center(
          child: Text(
            'Divided American Lives During War',
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        width: 140,
        child: Center(
          child: Text(
            'As Stocks Stagnate, Many Look to Currency',
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        width: 140,
        child: Center(
          child: Text(
            'Llamas Patrol the Central Coast of California',
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        width: 140,
        child: Center(
          child: Text(
            'A Fight For Aging Veterans',
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ];

    ScrollController _scrollController = ScrollController();

    return AnypixelBridge(
      child: Container(
        color: Colors.black,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          children: children,
        ),
      ),
      onPressed: (Offset offset) {
        print(offset.toString());
        _scrollController.position.animateTo(
          _scrollController.offset + (offset.dx > 70 ? 140 : -140),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}