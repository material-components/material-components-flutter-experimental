import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> _tabs;

  void _incrementCounter() {
    setState(() {
//      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabs = _buildTabs();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
//      print(_tabController.indexIsChanging);
      if (_tabController.indexIsChanging && _tabController.previousIndex != _tabController.index) {
        print('prev: ' + _tabController.previousIndex.toString());
        print('curr: ' + _tabController.index.toString());
        (_tabs[_tabController.previousIndex].child as _RallyTab).isExpanded = false;
        (_tabs[_tabController.index].child as _RallyTab).isExpanded = true;
      }
//      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
//            Image.asset('assets/logo.png'),
            TabBar(
                tabs: _buildTabs(),
                controller: _tabController
            ),
//            TabBarView(
//                children: _buildTabViews(),
//                controller: _tabController
//            )
          ],
        ),
      ),
    );
  }

  List<Tab> _buildTabs() {
    return <Tab>[
      _buildTab(Image.asset("assets/ic_pie_chart_24px"), "overview"),
      _buildTab(Image.asset("assets/ic_attach_money_24px"), "accounts"),
      _buildTab(Image.asset("assets/ic_money_off_24px"), "bills"),
      _buildTab(Image.asset("assets/ic_bar_chart_24px"), "budgets"),
      _buildTab(Image.asset("assets/ic_settings_24px"), "settings"),
    ];
  }

  Tab _buildTab(Image tabImage, String title) {
    return Tab(
        child: _AnimatedRallyTab(tabImage: tabImage, title: title)
    );
  }

  _buildTabViews() {
    return <Widget>[
      Image.asset('assets/logo.png'),
      Text('2'),
      Text('3'),
      Text('4'),
      Text('5'),
    ];
  }
}

//class _RallyTab extends AnimatedWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return null;
//  }
//
//}

class _AnimatedRallyTab extends StatelessWidget {
  Text titleText;
  Image image;

  _AnimatedRallyTab({
    Image tabImage,
    String title,
  }) : titleText = Text(title), image = tabImage;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        image,
        SizedBox(width: 32.0, child: titleText)
      ],
    );
  }
}

class _RallyTab extends StatefulWidget {
  Text titleText;
  Icon icon;
  bool _isExpanded;

  _RallyTab(
      IconData iconData,
      String title,
      bool isExpanded) {
    titleText = Text(title);
    icon = Icon(iconData);
    _isExpanded = isExpanded;
  }

  bool get isExpanded => _isExpanded;
  set isExpanded(bool isExpanded) => _isExpanded = isExpanded;

  _RallyTabState createState() => _RallyTabState();
}

class _RallyTabState extends State<_RallyTab> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    if (widget.isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.icon,
        RotationTransition(child: widget.titleText, turns: _animation)
      ],
    );
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }
}

