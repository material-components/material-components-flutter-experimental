import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Navigation Scaffold',
      home: AdaptiveNavigationScaffoldDemo(),
    );
  }
}

class AdaptiveNavigationScaffoldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Use the AdaptiveNavigationScaffold
    return Scaffold(
      body: Center(
        child: Text(
            'Resize the window to switch between the Navigation Rail and Bottom Navigation'),
      ),
    );
  }
}
