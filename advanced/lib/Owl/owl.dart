import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'short_bottom_sheet_owl.dart';

class OwlHomeWidget extends StatelessWidget {
  const OwlHomeWidget(this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Owl Colors'),
      ),
      body: Column(children: <Widget>[
        SizedBox(
        height: 40.0,
      ),
      Card(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.star,
              size: 120.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Title',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display2,
                ),
                Text(
                  'Subtitle',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1,
                )
              ],
            )
          ],
        ),
      ),
      SizedBox(height: 150.0),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                color: Theme
                    .of(context)
                    .accentColor,
                child: Text(
                  'Contained Button',
                  style: Theme
                      .of(context)
                      .textTheme
                      .button,
                ),
                onPressed: onPressed),
            OutlineButton(
              child: Text(
                'Outline Button',
                style: Theme
                    .of(context)
                    .textTheme
                    .button,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => OwlWidget()
                    )
                );
              }),
              ],
            ),
          ]),
    );
  }
}

class OwlWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OwlState();
}

const TextTheme textThemeOwl = TextTheme(
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
  body2: TextStyle(
    color: Colors.black87,
  ),
  title: TextStyle(
    color: Colors.black87,
    fontSize: 20.0,
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w800,
  ),
  caption: TextStyle(
    color: Colors.black87,
    fontSize: 14.0,
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w500,
  ),
  button: TextStyle(
    color: Colors.black38,
    fontSize: 14.0,
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w500,
  ),

);

class _OwlState extends State<OwlWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ShortBottomSheetOwl shortBottomSheet;


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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            ListView(
              children: [Column(children: <Widget>[
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
              ])
              ],
            ),
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
