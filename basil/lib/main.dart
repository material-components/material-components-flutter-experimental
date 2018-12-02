import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: BasilHomePage(),
    );
  }
}

class BasilHomePage extends StatelessWidget {
  final TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    color: Color(0xFF356859),
    fontSize: 60,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBE6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'BASiL',
              style: style,
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset(
                  'assets/spanakopita.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Spanakopita',
              style: style.apply(color: Color(0xFFFD5523)),
            ),
//            Expanded(),
            Image.asset('assets/arrow.png'),
          ],
        ),
      ),
    );
  }
}
