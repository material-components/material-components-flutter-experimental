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
//  List<Tab> _tabs;

  _HomePageState() {
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    print('_HomePageState initState');

    _tabController.addListener(() {
      if (_tabController.indexIsChanging && _tabController.previousIndex != _tabController.index) {
        print('prev: ' + _tabController.previousIndex.toString());
        print('curr: ' + _tabController.index.toString());
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  tabs: _buildTabs(),
                  controller: _tabController,
                  indicator: UnderlineTabIndicator(borderSide: BorderSide(style: BorderStyle.none)),
                ),
                Expanded(
                  child: TabBarView(
                      children: _buildTabViews(),
                      controller: _tabController
                  ),
                )
              ]),
        )
    );
  }

  List<Widget> _buildTabs() {
    print('_buildTabs');

    return <Widget>[
      _buildTab(Image.asset("assets/ic_pie_chart_24px.png"), "overview", 0),
      _buildTab(Image.asset("assets/ic_attach_money_24px.png"), "accounts", 1),
      _buildTab(Image.asset("assets/ic_money_off_24px.png"), "bills", 2),
      _buildTab(Image.asset("assets/ic_bar_chart_24px.png"), "budgets", 3),
      _buildTab(Image.asset("assets/ic_settings_24px.png"), "settings", 4),
    ];
  }

  List<Widget> _buildTabViews() {
    return <Widget>[
      ListView(children: [Image.asset('assets/logo.png')]),
      ListView(children: [Image.asset('assets/logo.png')]),
      ListView(children: [Image.asset('assets/logo.png')]),
      ListView(children: [Image.asset('assets/logo.png')]),
      ListView(children: [Image.asset('assets/logo.png')]),
    ];
  }

  Widget _buildTab(Image tabImage, String title, int index) {
    return _RallyTab(_tabController, tabImage, title, _tabController.index == index);
  }
}

class _RallyTab extends StatefulWidget {
  TabController tabController;
  Text titleText;
  Image iconImage;
  bool _isExpanded;

  _RallyTab(
      TabController tabController,
      Image iconImage,
      String title,
      bool isExpanded) {
    this.tabController = tabController;
    titleText = Text(title);
    this.iconImage = iconImage;
    _isExpanded = isExpanded;
  }

  bool get isExpanded => _isExpanded;
  set isExpanded(bool isExpanded) => _isExpanded = isExpanded;

  _RallyTabState createState() => _RallyTabState();
}

class _RallyTabState extends State<_RallyTab> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  initState() {
    super.initState();
    print('_RallyTabState initState ' + widget.isExpanded.toString());
    _controller = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this
    );
    _animation = Tween(begin: 1.0, end: 3.0).animate(_controller);
  }

  @override
  void didUpdateWidget(_RallyTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_RallyTabState didUpdateWidget ' + widget.isExpanded.toString());

    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      child: Container(
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueAccent)
          ),
          child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                  height: 40.0,
                  child: widget.iconImage,
                ),
                SizeTransition(
                    child: widget.titleText,
                  axis: Axis.horizontal,
                  axisAlignment: -1.0,
                  sizeFactor: _animation,),
              ],
            ),
      ),
    );
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }
}

