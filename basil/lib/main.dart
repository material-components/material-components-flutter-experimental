import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
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
    letterSpacing: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBE6),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Text(
                    'BASiL',
                    style: style,
                  ),
                  SizedBox(
                    height: 15.0,
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
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Spinach Pies',
                    textAlign: TextAlign.center,
                    style: style.apply(color: Color(0xFFFF3C00)),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/arrow.png'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
