import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/fortnightly/adaptive/shared.dart';

// Tested on Pixel 2
class FortnightlyPhonePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyPhonePortraitHome(),
    );
  }
}

class FortnightlyPhonePortraitHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: NavigationMenu(isCloseable: true),
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          SizedBox(width: 48, child: Icon(Icons.search)),
        ],
        title: Image.asset('assets/fortnightly_title.png'),
      ),
      body: ListView(
        children: <Widget>[
          HashtagBar(),
          ...buildArticlePreviewItems(context).map((w) => Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
      child: w,
    )),
        ],
      ),
    );
  }
}

ThemeData buildTheme(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
      ),
      textTheme: textTheme.copyWith(
          title: textTheme.title.copyWith(
            fontFamily: 'Merriweather',
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
          subtitle: textTheme.subtitle.copyWith(
            fontFamily: 'Libre Franklin',
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          headline: textTheme.headline.copyWith(
            fontFamily: 'Libre Franklin',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          subhead: textTheme.subhead.copyWith(
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )));
}
