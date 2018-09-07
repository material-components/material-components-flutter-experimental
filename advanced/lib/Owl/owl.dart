import 'package:flutter/material.dart';
import 'colors.dart';
import 'short_bottom_sheet_owl.dart';

class OwlWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OwlState();
}

class _OwlState extends State<OwlWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ShortBottomSheetOwl shortBottomSheet;

  static TextTheme textThemeOwl = TextTheme(
    subhead: TextStyle(
      color: kOwlRed,
      fontSize: 20.0,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
    ),
    display1: TextStyle(
      color: Colors.black87,
      fontSize: 30.0,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
    ),
    body1: TextStyle(
      color: Colors.black87,
      height: 1.8,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
      value: 1.0,
    );
    shortBottomSheet = ShortBottomSheetOwl(hideController: _controller);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              Image(image: AssetImage('assets/1.png')),
              SizedBox(height: 15.0),
              Text('TRAVEL', style: textThemeOwl.subhead),
              SizedBox(height: 5.0),
              Text(
                '\'Glamping\'\nand Other Annoying Portmanteaus',
                style: textThemeOwl.display1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'To access the tutorial videos for a course, tap the curved shape in the bottom right of the screen. This section is a hub for course content. Each course has an overview screen that contains tutorial videos.\nOwl is an educational app that provides courses for people who want to explore and learn new skills in design, art, architecture, and fashion. The Owl brand uses bold color, shape, and typography to express its brand attributes: energy, daring, and fun.\nOwl’s design reflects the energy and excitement of learning a new skill.',
                  style: textThemeOwl.body1,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            SafeArea(
              child: Column(children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ]),
            ),
            Align(child: shortBottomSheet, alignment: Alignment.bottomRight),
          ],
        ));
  }
}
