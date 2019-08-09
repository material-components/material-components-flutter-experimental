import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FortnightlyWristwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyWearableHome(),
    );
  }
}

class FortnightlyWearableHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.4,
              child: SizedBox.expand(
                child: Image.asset(
                  'assets/fortnightly_healthcare.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/fortnightly_title_white.png'),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child:  Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'The Quiet, Yet Powerful Healthcare Revolution',
                      style: textTheme.headline,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 15,
        ),
      ));
}
