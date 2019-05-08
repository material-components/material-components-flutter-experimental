import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/fortnightly/adaptive/shared.dart';

class FortnightlyFoldableOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyFoldableOpenHome(),
    );
  }
}

class FortnightlyFoldableOpenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 12),
                        child: Image.asset(
                          'assets/fortnightly_title.png',
                        ),
                      ),
                      fit: FlexFit.tight,
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      flex: 2,
                      child: HashtagBar(),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 16),
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: NavigationMenu(),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      flex: 2,
                      child: ListView(
                        children: buildArticlePreviewItems(context),
                      ),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: ListView(
                            children: <Widget>[
                            ...buildStockItems(context),
                        SizedBox(height: 32),
                        ...buildVideoPreviewItems(context),
                  ],
                ),
              ),
            ],
          ),
        ),
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
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
    ),
    textTheme: textTheme.copyWith(
      subtitle: textTheme.subtitle.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      headline: textTheme.headline.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w500,
      ),
      subhead: textTheme.subhead.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w700,
        fontSize: 11,
      )));
}