import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/fortnightly/adaptive/shared.dart';

class FortnightlyCounterClose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyCounterCloseHome(),
    );
  }
}

class FortnightlyCounterCloseHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget verticalDivider = Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      color: Colors.black.withOpacity(0.2),
      width: 1,
      height: 480,
    );
    final double articleWidth = 260;

    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
            child: Container(
          padding: EdgeInsets.only(left: 32),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset('assets/fortnightly_title.png'),
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: Icon(
                      Icons.search,
                      size: 32,
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    VerticalArticlePreview(
                      width: articleWidth,
                      data: ArticleData(
                        imageUrl: 'assets/fortnightly_dining.png',
                        category: 'POLITICS',
                        title: 'Modern Dining Rituals For Singles',
                        snippet:
                            'From the chef\'s table to restaurants for singles, modern cusine gets creative',
                      ),
                    ),
                    verticalDivider,
                    VerticalArticlePreview(
                      width: articleWidth,
                      data: ArticleData(
                        imageUrl: 'assets/fortnightly_poverty.png',
                        category: 'US',
                        title: 'Poverty To Empowerment In Chicago',
                        snippet:
                            'How one woman is transforming the lives of underprivileged children',
                      ),
                    ),
                    verticalDivider,
                    VerticalArticlePreview(
                      width: articleWidth,
                      data: ArticleData(
                        imageUrl: 'assets/fortnightly_veterans.png',
                        category: 'POLITICS',
                        title: 'A Fight For Aging Veterans',
                        snippet:
                            'For those nearing retirement, benefits are not always guaranteed',
                      ),
                    ),
                    verticalDivider,
                    SizedBox(
                      width: articleWidth,
                      child: Column(
                        children: buildStockItems(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

ThemeData buildTheme(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: textTheme.copyWith(
          headline: textTheme.headline.copyWith(
            fontFamily: 'Libre Franklin',
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
          body1: textTheme.body1.copyWith(
            fontFamily: 'Merriweather',
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
          subhead: textTheme.subhead.copyWith(
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          )));
}
