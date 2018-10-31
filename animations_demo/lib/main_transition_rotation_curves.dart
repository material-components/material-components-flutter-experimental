import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    // Create an animation controller, and rebuild the widget tree when we
    // listen to it, in order to generate frames.
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Set up the animation curve that we want to use.
    _animation = new CurvedAnimation(
      parent: _controller,
      // There are many different types of curves.
//      curve: Curves.elasticOut,
//      curve: Curves.fastOutSlowIn,
      curve: Curves.ease,
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _controller.value = 0.0;
      _controller.animateTo(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            RotationTransition(
              turns: _animation,
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 2000),
                style: Theme.of(context).textTheme.display1.copyWith(
                    color: _counter % 2 == 0 ? Colors.blue : Colors.pink
                ),
                child: new Text(
                  '$_counter',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
