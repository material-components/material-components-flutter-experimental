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
import 'dart:ui';

import 'model/flight.dart';
import 'model/data.dart';
import 'colors.dart';
import 'border_tab_indicator.dart';
import 'no_paint_rounded_border.dart';
//import 'menu_page.dart';

enum MenuStatus { open, closed }
enum FrontLayerStatus { open, partial, closed }

double _kFlingVelocity = 2.0;
MenuStatus _menuStatus = MenuStatus.closed;

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.onTap,
    this.child,
    this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 16.0,
        color: kCranePrimaryWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(
              height: 8.0,
            ),
            Column(
              children: _buildFlightCards(),
            ),
          ],
        ));
  }

  static List<Widget> _buildFlightCards() {
    List<Flight> flights = getFlights(Category.findTrips);
    return List.generate(flights.length, (int index) {
      return _DestinationCard(flight: flights[index]);
    }).toList();
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

class _BackdropState extends State<Backdrop> with TickerProviderStateMixin {
  AnimationController _controller;
  TabController _tabController;
  FrontLayerStatus _initFrontLayerStatus;
  FrontLayerStatus _targetFrontLayerStatus;
  AnimationController _xController;
  AnimationController _yController;
  var prevTabIndex;
  var _kFlingValue;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 0.0,
      vsync: this,
    );
    _xController = AnimationController(
        duration: const Duration(milliseconds: 500),
        value: 0.0,
//        upperBound: 2.0,
        vsync: this,
    );
    _yController = AnimationController(
        duration: const Duration(milliseconds: 500),
        value: 0.0,
        vsync: this,
    );
    _tabController = TabController(length: 3, vsync: this);
    prevTabIndex = 0;
    _initFrontLayerStatus = FrontLayerStatus.partial;
    _targetFrontLayerStatus = FrontLayerStatus.closed;
    _kFlingValue = 1.0;
  }

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

  void _flingFrontLayerVertical() {
    _controller.fling(
      velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity
    );
  }

  Animation<RelativeRect> _buildLayerAnimation(
      BuildContext context, double layerTop) {
    Size size = MediaQuery.of(context).size;
    double lowHeight = size.height - 144.0;
    Animation<RelativeRect> layerAnimation;

    RelativeRect begin;
    RelativeRect end;

    /// closed: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    /// partial: RelativeRect.fromLTRB(0.0, layerTop, 0.0, 0.0),
    ///
    /// menu open: RelativeRect.fromLTRB(0.0, 550.0, 0.0, 0.0),
    if (_initFrontLayerStatus == FrontLayerStatus.partial) {
      begin = RelativeRect.fromLTRB(0.0, layerTop, 0.0, 0.0);
    } else if (_initFrontLayerStatus == FrontLayerStatus.closed) {
      begin = RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0);
    } else {
      begin = RelativeRect.fromLTRB(0.0, lowHeight, 0.0, 0.0);
    }
    if (_targetFrontLayerStatus == FrontLayerStatus.partial) {
      end = RelativeRect.fromLTRB(0.0, layerTop, 0.0, 0.0);
    } else if (_targetFrontLayerStatus == FrontLayerStatus.closed) {
      end = RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0);
    } else {
      end = RelativeRect.fromLTRB(0.0, lowHeight, 0.0, 0.0);
    }
    layerAnimation = RelativeRectTween(
      begin: begin,
      end: end,
    ).animate(_controller.view);

    return layerAnimation;
  }

  Widget _buildFlyStack(BuildContext context, BoxConstraints constraints) {
    final double flyLayerTop = 236 + .0;

    Animation<RelativeRect> flyLayerAnimation =
        _buildLayerAnimation(context, flyLayerTop);

    return Stack(
      children: <Widget>[
//        widget.backLayer[0],
        PositionedTransition(
          rect: flyLayerAnimation,
          child: _FrontLayer(
            onTap: _flingFrontLayerVertical,
            child: widget.frontLayer,
            title: 'Explore Flights by Destination',
          ),
        ),
      ],
    );
  }

  Widget _buildSleepStack(BuildContext context, BoxConstraints constraints) {
    final double sleepLayerTop = 176 + .0;

    Animation<RelativeRect> sleepLayerAnimation =
        _buildLayerAnimation(context, sleepLayerTop);

    return Stack(
      children: <Widget>[
//        widget.backLayer[1],
        PositionedTransition(
          rect: sleepLayerAnimation,
          child: _FrontLayer(
            onTap: _flingFrontLayerVertical,
            child: widget.frontLayer,
            title: 'Explore Properties by Destination',
          ),
        ),
      ],
    );
  }

  Widget _buildEatStack(BuildContext context, BoxConstraints constraints) {
    final double eatLayerTop = 236 + .0;

    Animation<RelativeRect> eatLayerAnimation =
        _buildLayerAnimation(context, eatLayerTop);

    return Stack(
      children: <Widget>[
//        widget.backLayer[2],
        PositionedTransition(
          rect: eatLayerAnimation,
          child: _FrontLayer(
            onTap: _flingFrontLayerVertical,
            child: widget.frontLayer,
            title: 'Explore Restaurants by Destination',
          ),
        ),
      ],
    );
  }

  Widget _buildMainApp(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    double transitionPadding = 16.0 / mediaSize.width;
    void _handleTabs(var tabIndex) {
      if (_tabController.index == tabIndex) {
//          if (_targetFrontLayerStatus == FrontLayerStatus.closed) {
//            _targetFrontLayerStatus = FrontLayerStatus.partial;
//            _initFrontLayerStatus = FrontLayerStatus.closed;
//          } else {
//            _targetFrontLayerStatus = FrontLayerStatus.closed;
//            _initFrontLayerStatus = FrontLayerStatus.partial;
//          }
        setState(() {});
        _flingFrontLayerVertical();
      }
      else {
//        if (_controller.status == AnimationStatus.completed) {
//          _controller.reverse();
//        }
//        _xController.value = tabIndex;
        _tabController.animateTo(tabIndex);
        if (tabIndex + prevTabIndex < 2) {
          _xController.fling(
            velocity: (tabIndex - prevTabIndex) * _kFlingVelocity,
          );
//          _xController.value = 0.0;
        }
        else if (tabIndex + prevTabIndex == 2) {
          _yController.fling(
            velocity: (tabIndex - prevTabIndex) * _kFlingVelocity,
          );
//          _xController.value = 1.0;
        }
        else {
//          _xController.value = 2.0;
          _xController.fling(
            velocity: (tabIndex - prevTabIndex) * _kFlingVelocity,
          );
          _yController.fling(
            velocity: (tabIndex - prevTabIndex) * _kFlingVelocity,
          );
        }
        prevTabIndex = tabIndex;
      }
    }
//
//    bool _isSelected(var tabIndex) {
//      if (_tabController.index == tabIndex) {
//        return true;
//      }
//      return false;
//    }

    var appBar = AppBar(
      brightness: Brightness.dark,
      elevation: 0.0,
      titleSpacing: 0.0,
      // TODO(tianlun): Replace IconButton icon with Crane logo.
      flexibleSpace: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _SplashOverride(
              color: kCraneAlpha,
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
//                    setState(() {
//                    _menuStatus = MenuStatus.open;
//                    _initFrontLayerStatus = _targetFrontLayerStatus;
//                    _targetFrontLayerStatus = FrontLayerStatus.open;
//                    });
//                    _flingFrontLayer();
                  },
                ),
              ),
            ),
            Container(
              height: 100.0,
              width: mediaSize.width - 52.0,
              child: _SplashOverride(
                color: kCraneAlpha,
                child: TabBar(
                  indicator: BorderTabIndicator(),
                  controller: _tabController,
                  tabs: <Widget>[
                    Container(
                      height: 25.0,
                      width: 75.0,
                      child: FlatButton(
                        child: Text(
                          'FLY',
//                          style: Theme.of(context).textTheme.body2.copyWith(
//                            color: kCranePrimaryWhite,
//                            fontWeight: FontWeight.w600,
//                          ),
                        ),
                        textColor: kCranePrimaryWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        onPressed: () => _handleTabs(0),
                      ),
                    ),
                    Container(
                      height: 25.0,
                      width: 75.0,
                      child: FlatButton(
                        child: Text(
                          'SLEEP',
//                          style: Theme.of(context).textTheme.body2.copyWith(
//                            color: kCranePrimaryWhite,
//                            fontWeight: FontWeight.w600,
//                          ),
                        ),
                        textColor: kCranePrimaryWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        onPressed: () => _handleTabs(1),
                      ),
                    ),
                    Container(
                      height: 25.0,
                      width: 75.0,
                      child: FlatButton(
                        child: Text(
                          'EAT',
//                          style: Theme.of(context).textTheme.body2.copyWith(
//                            color: kCranePrimaryWhite,
//                            fontWeight: FontWeight.w600,
//                          ),
                        ),
                        textColor: kCranePrimaryWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        onPressed: () => _handleTabs(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Material(
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: appBar,
            body: Stack(
              children: <Widget>[
                widget.backLayer[0],
                  SlideTransition(
                    transformHitTests: false,
                    position: Tween<Offset>(
                      begin: Offset(0.0, 0.0),
                      end: Offset(0.0 - _kFlingValue, 0.0),
                    ).animate(
                      CurvedAnimation(
                        parent: _xController,
                        curve: Interval(0.0, 1.0),
                        reverseCurve: Interval(0.0, 1.0).flipped,
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: _buildFlyStack,
                    ),
                  ),
                  SlideTransition(
                    transformHitTests: false,
                    position: Tween<Offset>(
                      begin: Offset(1.0 + transitionPadding, 0.0),
                      end: Offset(1.0 - _kFlingValue, 0.0),
                    ).animate(
                      CurvedAnimation(
                        parent: _xController,
                        curve: Interval(0.0, 1.0),
                        reverseCurve: Interval(0.0, 1.0).flipped,
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: _buildSleepStack,
                    ),
                  ),
//                 SlideTransition(
//                  position: Tween<Offset>(
//                    begin: Offset(0.0, 0.0),
//                    end: Offset(-1.0, 0.0),
//                  ).animate(
//                    CurvedAnimation(
//                      parent: _yController,
//                      curve: Interval(0.0, 1.0),
//                      reverseCurve: Interval(0.0, 1.0).flipped,
//                    ),
//                  ),
//                  child: LayoutBuilder(
//                    builder: _buildSleepStack,
//                  ),
//                ),
                SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: Offset(2.0 + transitionPadding, 0.0),
                    end: Offset(2.0 - _kFlingValue, 0.0),
                  ).animate(
                    CurvedAnimation(
                      parent: _xController,
                      curve: Interval(0.0, 1.0),
                      reverseCurve: Interval(0.0, 1.0).flipped,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: _buildEatStack,
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            child: _buildMenu(context),
            builder: _buildMenuTransition,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTransition(BuildContext context, Widget child) {
    return _targetFrontLayerStatus == FrontLayerStatus.open
        // TODO: check animation status and menu open / close status
        ? FadeTransition(
            opacity: _controller,
            child: child,
          )
        : Container();
  }

  Widget _buildMenu(BuildContext context) {
    return Material(
      child: Container(
        constraints: BoxConstraints(maxWidth: 375.0, maxHeight: 400.0),
        padding: EdgeInsets.only(top: 40.0),
        color: kCranePurple800,
        child: ListView(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  semanticLabel: 'back',
                ),
                onPressed: () {
                  setState(() {
                    _menuStatus = MenuStatus.closed;
                    _targetFrontLayerStatus = _initFrontLayerStatus;
                    _initFrontLayerStatus =
                        _initFrontLayerStatus == FrontLayerStatus.closed
                            ? FrontLayerStatus.partial
                            : FrontLayerStatus.closed;
                    _controller.forward();
                  });
                }),
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
    return Material(
      child: _buildMainApp(context),
    );
  }
}

class _SplashOverride extends StatelessWidget {
  const _SplashOverride({Key key, this.color, this.child}) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data:
          Theme.of(context).copyWith(splashColor: color, highlightColor: color),
    );
  }
}

class _PrimaryColorOverride extends StatelessWidget {
  const _PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      // TODO(tianlun): Change the color of the text theme instead
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  _DestinationCard({this.flight}) : assert(flight != null);
  final Flight flight;

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.asset(
      flight.assetName,
      fit: BoxFit.cover,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: SizedBox(
              height: 60.0,
              width: 60.0,
              child: imageWidget,
            ),
          ),
          title: Text(
            flight.destination,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            flight.layover ? 'Layover' : 'Nonstop',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        SizedBox(
          child: Divider(
            indent: 4.0,
          ),
        ),
      ],
    );
  }
}
