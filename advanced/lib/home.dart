import 'package:flutter/material.dart';
import 'icons.dart';
import 'Shrine/app.dart';
import 'Crane/app.dart';
import 'Owl/owl.dart';

class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Android Summit 2018'),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.all(4.0),
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CraneApp()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Material(
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      'Crane',
                      style: Theme.of(context).textTheme.display1,
                    ))),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => IconsPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Material(
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      'Icons',
                      style: Theme.of(context).textTheme.display1,
                    ))),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ShrineApp()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Material(
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      'Easy',
                      style: Theme.of(context).textTheme.display1,
                    ))),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ThemeColorOverride(
                          color: kOwlYellow,
                          secondary: kOwlBlue,
                          textColor: Colors.black,
                          child: OwlWidget(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ThemeColorOverride(
                                      color: kOwlRed,
                                      secondary: kOwlRed,
                                      textColor: Colors.white,
                                      child: OwlWidget(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ThemeColorOverride(
                                                      color: kOwlBlue,
                                                      secondary: kOwlYellow,
                                                      textColor: Colors.white,
                                                      child: OwlWidget(() {}))),
                                        );
                                      }),
                                    ),
                              ),
                            );
                          }),
                        ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Material(
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      'Owl',
                      style: Theme.of(context).textTheme.display1,
                    ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeColorOverride extends StatelessWidget {
  const ThemeColorOverride(
      {Key key, this.color, this.secondary, this.textColor, this.child})
      : super(key: key);

  final Color color;
  final Color secondary;
  final Color textColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
          primaryColor: color,
          accentColor: secondary,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor)),
    );
  }
}

const kOwlYellow = const Color(0xFFFFDE03);
const kOwlBlue = const Color(0xFF0336FF);
const kOwlRed = const Color(0xFFFF0266);
