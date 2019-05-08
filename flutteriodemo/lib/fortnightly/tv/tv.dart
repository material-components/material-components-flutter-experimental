import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/fortnightly/adaptive/shared.dart';

class FortnightlyTv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyTvHome(),
    );
  }
}

class FortnightlyTvHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            padding: EdgeInsets.only(left: 32),
            color: Colors.black,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/fortnightly_title_white.png'),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text('Top Highlights', style: textTheme.title),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: TvRow(),
                      ),
                      SizedBox(height: 20),
//                      Container(
//                        alignment: Alignment.centerLeft,
//                        padding: EdgeInsets.only(top: 20, bottom: 20),
//                        child: Text('Last Updated', style: textTheme.title),
//                      ),
//                      Opacity(
//                        opacity: 0.70,
//                        child: SingleChildScrollView(
//                          scrollDirection: Axis.horizontal,
//                          child: TvRow(),
//                        ),
//                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TvRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double articleWidth = 132;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        VerticalArticlePreview(
          width: articleWidth,
          showSnippet: true,
          data: ArticleData(
            imageUrl: 'assets/fortnightly_dining.png',
            category: 'POLITICS',
            title: 'Modern Dining Rituals For Singles',
            snippet:
            'From the chef\'s table to restaurants for singles, modern cusine gets creative',
          ),
        ),
        SizedBox(width: 20),
        VerticalArticlePreview(
          width: articleWidth,
          showSnippet: true,
          data: ArticleData(
            imageUrl: 'assets/fortnightly_poverty.png',
            category: 'US',
            title: 'Poverty To Empowerment In Chicago',
            snippet:
            'How one woman is transforming the lives of underprivileged children',
          ),
        ),
        SizedBox(width: 20),
        VerticalArticlePreview(
          width: articleWidth,
          showSnippet: true,
          data: ArticleData(
            imageUrl: 'assets/fortnightly_veterans.png',
            category: 'POLITICS',
            title: 'A Fight For Aging Veterans',
            snippet:
            'For those nearing retirement, benefits are not always guaranteed',
          ),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: 130,
          child: Column(
            children: buildStockItems(context, isTv: true)
                .sublist(0, 9),
          ),
        ),
        SizedBox(width: 20),
        VerticalArticlePreview(
          width: articleWidth,
          showSnippet: true,
          data: ArticleData(
            imageUrl: 'assets/fortnightly_dining.png',
            category: 'POLITICS',
            title: 'Modern Dining Rituals For Singles',
            snippet:
            'From the chef\'s table to restaurants for singles, modern cusine gets creative',
          ),
        ),
        SizedBox(width: 20),
        VerticalArticlePreview(
          width: articleWidth,
          showSnippet: true,
          data: ArticleData(
            imageUrl: 'assets/fortnightly_poverty.png',
            category: 'US',
            title: 'Poverty To Empowerment In Chicago',
            snippet:
            'How one woman is transforming the lives of underprivileged children',
          ),
        ),
        SizedBox(width: 20),
        VerticalArticlePreview(
          width: articleWidth,
          showSnippet: true,
          data: ArticleData(
            imageUrl: 'assets/fortnightly_veterans.png',
            category: 'POLITICS',
            title: 'A Fight For Aging Veterans',
            snippet:
            'For those nearing retirement, benefits are not always guaranteed',
          ),
        ),
      ],
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
        // preview headlines
        headline: textTheme.headline.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16,
        ),
        // preview snippet
        body1: textTheme.body1.copyWith(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w300,
          color: Colors.white.withOpacity(0.76),
          fontSize: 12,
        ),
        // caption 2, category subtitle
        subhead: textTheme.subhead.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white.withOpacity(0.50),
        ),
        subtitle: textTheme.caption.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white,
        ),
        // stock ticker
        caption: textTheme.caption.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white,
        ),
        // Top Highlights, Last Updated...
        title: textTheme.title.copyWith(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          fontSize: 14,
          color: Colors.white,
        ),
      ));
}
