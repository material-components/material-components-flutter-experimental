import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Scene1 extends StatefulWidget {
  @override
  _Scene1State createState() => _Scene1State();
}

class _Scene1State extends State<Scene1> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      adapt: Platform.isMacOS,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(leading: Icon(Icons.ac_unit), title: Text('AC Unit')),
            ListTile(leading: Icon(Icons.backspace), title: Text('Backspace')),
            ListTile(leading: Icon(Icons.cached), title: Text('Cached')),
            ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
            ListTile(leading: Icon(Icons.edit), title: Text('Edit')),
            ListTile(leading: Icon(Icons.four_k), title: Text('Four K')),
            ListTile(leading: Icon(Icons.g_translate), title: Text('Google Translate')),
            ListTile(leading: Icon(Icons.hd), title: Text('HD')),
            ListTile(leading: Icon(Icons.image), title: Text('Image')),
            ListTile(leading: Icon(Icons.format_align_justify), title: Text('Format')),
            ListTile(leading: Icon(Icons.keyboard), title: Text('Keyboard')),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Scene 1"),
      ),
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