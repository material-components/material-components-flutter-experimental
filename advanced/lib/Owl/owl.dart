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
  ));

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
              SizedBox(height: 15.0),
              Text('Glamping and Other Annoying Portmanteaus',
                  style: textThemeOwl.display1),
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
