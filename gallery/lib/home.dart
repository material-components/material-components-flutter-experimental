import 'package:flutter/material.dart';

import 'demo.dart';
import 'settings.dart';
import 'splash.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        leading: IconButton(icon: Icon(Icons.color_lens), onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => SplashPage(),
            ),
          );
        }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => SettingsPage(),
              ),
            );
          }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome!',
            ),
            RaisedButton(
              child: Text('Demo'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DemoPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}