import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../anypixel.dart';

class AnypixelStarterDemo extends StatefulWidget {
  @override
  AnypixelStarterDemoState createState() => AnypixelStarterDemoState();
}

class AnypixelStarterDemoState extends State<AnypixelStarterDemo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .primaryTextTheme
        .headline
        .copyWith(fontSize: 12, letterSpacing: 1);
    final key = Key('fab');
    return AnypixelBridge(
      child: Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Pressed', style: style),
                Text('$count', style: style),
                Text('times', style: style),
              ],
            ),
            FloatingActionButton(
              key: key,
              mini: true,
              child: Icon(Icons.add),
              onPressed: () { },
            ),
          ],
        ),
      ),
      onPressed: (Offset offset) {
        setState(() {
          count++;
        });
      },
    );
  }
}

