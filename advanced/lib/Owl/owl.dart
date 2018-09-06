import 'package:flutter/material.dart';

class OwlWidget extends StatelessWidget {
  const OwlWidget(this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                onPressed: onPressed),
            OutlineButton(
                child: Text(
                  'Outline Button',
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {})
          ],
        ),
      ]),
    );
  }
}
