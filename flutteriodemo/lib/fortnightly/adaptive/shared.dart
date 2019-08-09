import 'package:flutter/material.dart';

class ArticleData {
  ArticleData({this.imageUrl, this.category, this.title, this.snippet});

  final String imageUrl;
  final String category;
  final String title;
  final String snippet;
}

class HorizontalArticlePreview extends StatelessWidget {
  HorizontalArticlePreview({this.data, this.time});

  final ArticleData data;
  final String time;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.category,
                style: textTheme.subhead,
              ),
              SizedBox(height: 12),
              Text(
                data.title,
                style: textTheme.headline.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
        if (time != null) ...[
          Text('2M', style: textTheme.body2),
          SizedBox(width: 8)
        ],
        Image.asset(
          data.imageUrl,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

class VerticalArticlePreview extends StatelessWidget {
  VerticalArticlePreview({
    this.data,
    this.width,
    this.headlineTextStyle,
    this.showSnippet = false,
  });

  final ArticleData data;
  final double width;
  final TextStyle headlineTextStyle;
  final bool showSnippet;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: width ?? double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              data.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 12),
          Text(
            data.category,
            style: textTheme.subhead,
          ),
          SizedBox(height: 12),
          Text(
            data.title,
            style: headlineTextStyle ?? textTheme.headline,
          ),
          if (showSnippet) ...[
            SizedBox(height: 4),
            Text(
              data.snippet,
              style: textTheme.body1,
            ),
          ],
        ],
      ),
    );
  }
}

List<Widget> buildArticlePreviewItems(BuildContext context) {
  Widget articleDivider = Container(
    margin: EdgeInsets.only(top: 16, bottom: 16),
    color: Colors.black.withOpacity(0.07),
    height: 1,
  );
  Widget sectionDivider = Container(
    margin: EdgeInsets.only(top: 16, bottom: 16),
    color: Colors.black.withOpacity(0.2),
    height: 1,
  );
  TextTheme textTheme = Theme.of(context).textTheme;

  return [
    VerticalArticlePreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_healthcare.png',
        category: 'WORLD',
        title: 'The Quiet, Yet Powerful Healthcare Revolution',
      ),
      headlineTextStyle: textTheme.headline.copyWith(fontSize: 20),
    ),
    articleDivider,
    HorizontalArticlePreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_war.png',
        category: 'POLITICS',
        title: 'Divided American Lives During War',
      ),
    ),
    articleDivider,
    HorizontalArticlePreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_gas.png',
        category: 'TECH',
        title: 'The Future of Gasoline',
      ),
    ),
    sectionDivider,
    Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Text('Latest Updates', style: textTheme.title),
    ),
    articleDivider,
    HorizontalArticlePreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_army.png',
        category: 'POLITICS',
        title: 'Reforming The Green Army From Within',
      ),
      time: '2M',
    ),
    articleDivider,
    HorizontalArticlePreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_stocks.png',
        category: 'WORLD',
        title: 'As Stocks Stagnate, Many Look To Currency',
      ),
      time: '2M',
    ),
    articleDivider,
    HorizontalArticlePreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_fabrics.png',
        category: 'TECH',
        title: 'Designes Use Tech To Make Futuristic Fabrics',
      ),
      time: '2M',
    ),
    articleDivider,
  ];
}

class HashtagBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget verticalDivider = Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      color: Colors.black.withOpacity(0.1),
      width: 1,
    );
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 32,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 16),
          Center(
            child: Text(
              '#TechDesign',
              style: textTheme.subtitle,
            ),
          ),
          verticalDivider,
          Center(
            child: Text(
              '#Reform',
              style: textTheme.subtitle,
            ),
          ),
          verticalDivider,
          Center(
            child: Text(
              '#HealthcareRevolution',
              style: textTheme.subtitle,
            ),
          ),
          verticalDivider,
          Center(
            child: Text(
              '#GreenArmy',
              style: textTheme.subtitle,
            ),
          ),
          verticalDivider,
          Center(
            child: Text(
              '#Stocks',
              style: textTheme.subtitle,
            ),
          ),
          verticalDivider,
        ],
      ),
    );
  }
}

class NavigationMenu extends StatelessWidget {
  NavigationMenu({this.isCloseable = false});

  final bool isCloseable;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        if (isCloseable)
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              Image.asset('assets/fortnightly_title.png'),
            ],
          ),
        SizedBox(height: 32),
        MenuItem(
          'Front Page',
          header: true,
        ),
        MenuItem('World'),
        MenuItem('US'),
        MenuItem('Politics'),
        MenuItem('Business'),
        MenuItem('Tech'),
        MenuItem('Science'),
        MenuItem('Sports'),
        MenuItem('Travel'),
        MenuItem('Culture'),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  MenuItem(this.title, {this.header = false});

  final String title;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            alignment: Alignment.centerLeft,
            child: header ? null : Icon(Icons.arrow_drop_down),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subhead.copyWith(
                  fontWeight: header ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}

class StockItem extends StatelessWidget {
  StockItem({this.ticker, this.price, this.percent});

  final String ticker;
  final String price;
  final double percent;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(ticker, style: textTheme.subhead),
        SizedBox(height: 2),
        Row(
          children: <Widget>[
            Text(price,
                style: textTheme.subtitle.copyWith(
                    color: textTheme.subtitle.color.withOpacity(0.75))),
            Spacer(),
            Text(
              percent > 0 ? '+' : '-',
              style: textTheme.subtitle.copyWith(
                fontSize: 12,
                color: percent > 0 ? Color(0xff20CF63) : Color(0xff661FFF),
              ),
            ),
            SizedBox(width: 4),
            Text(
              percent.abs().toStringAsFixed(2) + '%',
              style: textTheme.caption.copyWith(
                fontSize: 12,
                color: textTheme.subtitle.color.withOpacity(0.75),
              ),
            ),
          ],
        )
      ],
    );
  }
}

List<Widget> buildStockItems(BuildContext context, {bool isTv = false}) {
  Widget articleDivider = Container(
    margin: EdgeInsets.only(top: 16, bottom: 16),
    color: Colors.black.withOpacity(0.07),
    height: 1,
  );

  return [
    SizedBox(
      width: double.infinity,
      child: Image.asset(
        'assets/fortnightly_chart${isTv ? '_tv' : ''}.png',
        fit: BoxFit.contain,
      ),
    ),
    articleDivider,
    StockItem(
      ticker: 'DIJA',
      price: '7,031.21',
      percent: -0.48,
    ),
    articleDivider,
    StockItem(
      ticker: 'SP',
      price: '1,967.84',
      percent: 0.00,
    ),
    articleDivider,
    StockItem(
      ticker: 'Nasdaq',
      price: '6,211.46',
      percent: 0.52,
    ),
    articleDivider,
    StockItem(
      ticker: 'Nikkei',
      price: '5,891',
      percent: 1.16,
    ),
    articleDivider,
    StockItem(
      ticker: 'DJ Total',
      price: '89.02',
      percent: 0.80,
    ),
    articleDivider,
  ];
}

class VideoPreview extends StatelessWidget {
  VideoPreview({this.data, this.time});

  final ArticleData data;
  final String time;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            child: Image.asset(data.imageUrl, fit: BoxFit.contain)),
        SizedBox(height: 4),
        Row(
          children: <Widget>[
            Text(data.category, style: textTheme.subhead),
            Spacer(),
            Text(time, style: textTheme.body2)
          ],
        ),
        SizedBox(height: 4),
        Text(data.title, style: textTheme.headline.copyWith(fontSize: 16)),
      ],
    );
  }
}

List<Widget> buildVideoPreviewItems(BuildContext context) {
  return [
    VideoPreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_feminists.png',
        category: 'POLITICS',
        title: 'Feminists Take On Partisanship',
      ),
      time: '2:31',
    ),
    SizedBox(height: 32),
    VideoPreview(
      data: ArticleData(
        imageUrl: 'assets/fortnightly_bees.png',
        category: 'US',
        title: 'Farmland Bees In Short Supply',
      ),
      time: '1:37',
    ),
  ];
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
      // preview snippet
      body1: textTheme.body1.copyWith(
        fontFamily: 'Merriweather',
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      // time in latest updates
      body2: textTheme.body2.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w500,
        fontSize: 11,
        color: Colors.black.withOpacity(0.5),
      ),
      // preview headlines
      headline: textTheme.headline.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      // (caption 2), preview category, stock ticker
      subhead: textTheme.subhead.copyWith(
        fontFamily: 'Roboto Condensed',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      subtitle: textTheme.subtitle.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      // section titles: Top Highlights, Last Updated...
      title: textTheme.title.copyWith(
        fontFamily: 'Merriweather',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        fontSize: 14,
      ),
    ),
  );
}
