// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'model/product.dart';
import 'app.dart';
import 'colors.dart';
//import 'menu_page.dart';
double _kFlingVelocity = 2.0;

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0)
        ),
      ),
      child: new ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          // TODO(tianlun): Move Cards elsewhere to reduce clutter
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
              ],
            ),
          ),
          new Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('Last'),
                  subtitle: const Text('Card'),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        SizedBox(
          width: 72.0,
          child: IconButton(
            icon: Icon(
              Icons.menu,
              semanticLabel: 'menu',
            ),
            padding: EdgeInsets.only(right: 8.0),
            onPressed: this.onPress,
          ),
        ),
      ]),
    );
  }
}

/// Builds a Backdrop.
///
/// A Backdrop widget has two layers, front and back. The front layer is shown
/// by default, and slides down to show the back layer, from which a user
/// can make a selection. The user can also configure the titles for when the
/// front or back layer is showing.
class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final List<Widget> backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with TickerProviderStateMixin {

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  OverlayEntry _menuEntry;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
    _menuEntry =
        OverlayEntry(builder: (BuildContext context) => _buildMenu(context));
  }

//  @override
//  void didUpdateWidget(Backdrop old) {
//    super.didUpdateWidget(old);
//    // TODO(tianlun): Update to Crane categories
//    if (widget.currentCategory != old.currentCategory) {
//      _toggleBackdropLayerVisibility();
//    } else if (!_frontLayerVisible) {
//      _controller.fling(velocity: _kFlingVelocity);
//    }
//  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildFlyStack(BuildContext context, BoxConstraints constraints) {
    double flyLayerTitleHeight = 320+.0;
    final Size flyLayerSize = constraints.biggest;
    final double flyLayerTop = flyLayerSize.height - flyLayerTitleHeight;

    Animation<RelativeRect> flyLayerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: RelativeRect.fromLTRB(
        0.0, flyLayerTop, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
//      key: _backdropKey,
      children: <Widget>[
        widget.backLayer[0],
        PositionedTransition(
          rect: flyLayerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  Widget _buildSleepStack(BuildContext context, BoxConstraints constraints) {
    double sleepLayerTitleHeight = 385+.0;
    final Size sleepLayerSize = constraints.biggest;
    final double sleepLayerTop = sleepLayerSize.height - sleepLayerTitleHeight;

    Animation<RelativeRect> sleepLayerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: RelativeRect.fromLTRB(
          0.0, sleepLayerTop, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
//      key: _backdropKey,
      children: <Widget>[
        widget.backLayer[1],
        PositionedTransition(
          rect: sleepLayerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  Widget _buildEatStack(BuildContext context, BoxConstraints constraints) {
    double eatLayerTitleHeight = 320+.0;
    final Size eatLayerSize = constraints.biggest;
    final double eatLayerTop = eatLayerSize.height - eatLayerTitleHeight;

    Animation<RelativeRect> eatLayerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: RelativeRect.fromLTRB(
          0.0, eatLayerTop, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
//      key: _backdropKey,
      children: <Widget>[
        widget.backLayer[2],
        // Use a boolean that is switched on menu icon press
        // set above line to a ternary that either displays
        PositionedTransition(
          rect: eatLayerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
              child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  Widget _buildMainApp(BuildContext context) {
    final _tabController = TabController(length: 3, vsync: this);

    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      // TODO(tianlun): Replace IconButton icon with Crane logo.
      flexibleSpace: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 16.0, 12.0, 0.0),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Insert Overlay Entry
//                Overlay.of(context).insert(_menuEntry);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 36.0, bottom: 10.0),
            height: 150.0,
            width: 300.0,
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                GestureDetector(
                  onTap: () {
                    _toggleBackdropLayerVisibility();
                  },
                  child: Tab(
                  text: 'FLY',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                  _toggleBackdropLayerVisibility();
                  },
                  child:  Tab(
                    text: 'SLEEP',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                  _toggleBackdropLayerVisibility();
                  },
                  child:  Tab(
                    text: 'EAT',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: appBar,
        body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              LayoutBuilder(
                builder: _buildFlyStack,
              ),
              LayoutBuilder(
                builder: _buildSleepStack,
              ),
              LayoutBuilder(
                builder: _buildEatStack,
              ),
            ]
        )
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        color: kCranePurple800,
        child: ListView(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                semanticLabel: 'back',
              ),
              onPressed: (){
                _menuEntry.remove();
              }
            ),
            Text('Find Trips'),
            Text('My Trips'),
            Text('Saved Trips'),
            Text('Price Alerts'),
            Text('My Account'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO(tianlun): Toggle backdrop with onPressed of current tab

    return Material(
      child: Overlay(
        initialEntries: <OverlayEntry>[
          OverlayEntry(builder: (BuildContext context) => _buildMainApp(context)),
        ],
//          Scaffold(
//            appBar: appBar,
//            body: TabBarView(
//                controller: _tabController,
//                children: <Widget>[
//                  LayoutBuilder(
//                    builder: _buildFlyStack,
//                  ),
//                  LayoutBuilder(
//                    builder: _buildSleepStack,
//                  ),
//                  LayoutBuilder(
//                    builder: _buildEatStack,
//                  ),
//                ]
//            )
//        ),
      ),
    );
  }
}

class MenuHero extends StatelessWidget {
  const MenuHero({
    Key key,
    this.menu,
    this.onTap,
    this.width
  }) : super(key: key);

  final String menu;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: menu,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.only(top: 40.0),
              color: kCranePurple800,
              child: ListView(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      semanticLabel: 'back',
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    }
                  ),
                  Text('Find Trips'),
                  Text('My Trips'),
                  Text('Saved Trips'),
                  Text('Price Alerts'),
                  Text('My Account'),
                ],
              ),
            ),// overlay here
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
//    timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: MenuHero(
          menu: 'menu',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return Scaffold(
                  body: Container(
                    // The blue background emphasizes that it's a new route.
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.topLeft,
                    child: MenuHero(
                      menu: 'menu',
                      width: 100.0,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              }
            ));
          },
        ),
      ),
    );
  }
}