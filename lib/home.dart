import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RallyHomePage extends StatefulWidget {
  RallyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RallyHomePageState createState() => _RallyHomePageState();
}

class _RallyHomePageState extends State<RallyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
