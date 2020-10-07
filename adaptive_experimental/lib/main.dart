import 'dart:io';

import 'scene2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void _desktopInitHack() {
  if (kIsWeb) return;

  if (Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  } else if (Platform.isFuchsia) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _desktopInitHack();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF6200EE),
        accentColor: Color(0xFF03DAC5),
        colorScheme: Theme.of(context)!.colorScheme.copyWith(primary: Color(0xFF6200EE), secondary: Color(0xFF03DAC5)),
      ),
      home: Scene2(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Adaptive Scaffold Demos')),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 12),
            _SceneItem(routeName: '/scene1', title: 'Scene 1'),
            SizedBox(height: 12),
            _SceneItem(routeName: '/scene2', title: 'Scene 2'),
          ],
        ));
  }
}

class _SceneItem extends StatelessWidget {
  _SceneItem({required this.routeName, required this.title});

  final String routeName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        color: Colors.blueGrey.withOpacity(0.12),
        height: 80,
        child: Center(child: Text(title)),
      ),
    );
  }
}
