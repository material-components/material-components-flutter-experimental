import 'package:flutter/material.dart';
import 'short_bottom_sheet_owl.dart';

class OwlWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OwlState();
}

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
    // TODO: implement build
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Owl Colors'),
        ),
        body: Stack(
          children: <Widget>[
            Column(children: <Widget>[
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
                          style: Theme.of(context).textTheme.display2,
                        ),
                        Text(
                          'Subtitle',
                          style: Theme.of(context).textTheme.display1,
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
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Contained Button',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: null),
                  OutlineButton(
                      child: Text(
                        'Outline Button',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {}),
                ],
              ),
            ]),
            Align(child: shortBottomSheet, alignment: Alignment.bottomRight),
          ],
        ));
  }
}
