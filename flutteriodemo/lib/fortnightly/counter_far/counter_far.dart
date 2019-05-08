import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FortnightlyCounterFar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyCounterFarHome(),
    );
  }
}

class FortnightlyCounterFarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SizedBox.expand(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.only(left: 48, right: 48),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
                child: Opacity(
                  opacity: 0.75,
                  child: Image.asset('assets/fortnightly_title_white.png'),
                ),
              ),
              Spacer(),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'WORLD',
                            style: textTheme.subhead,
                          ),
                          SizedBox(height: 32),
                          Text(
                            'The Quiet, Yet Powerful Healthcare Revolution',
                            style: textTheme.headline,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: Image.asset('assets/fortnightly_healthcare.png')),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

ThemeData buildTheme(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: textTheme.copyWith(
      // preview headlines
      headline: textTheme.headline.copyWith(
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w500,
        fontSize: 48,
        color: Colors.white,
      ),
      // (caption 2), preview category, stock ticker
      subhead: textTheme.subhead.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: Colors.white,
      ),
    ),
  );
}
