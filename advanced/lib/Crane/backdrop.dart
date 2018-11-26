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
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'dart:ui';

import 'model/flight.dart';
import 'model/data.dart';
import 'colors.dart';
import 'border_tab_indicator.dart';

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.title,
    this.index,
  }) : super(key: key);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
        elevation: 16.0,
        color: kCranePrimaryWhite,
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 12.0)),
            SizedBox(height: 8.0),
            ItemCards(index: index),
          ],
        ),
    );
  }
}

class ItemCards extends StatelessWidget {
  final int index;

  const ItemCards({ Key key, this.index }) : super(key: key);

  static List<Widget> _buildFlightCards({ int listIndex }) {
    final List<Flight> flightsFly = getFlights(Category.findTrips)..shuffle();
    final List<Flight> flightsSleep = getFlights(Category.findTrips)..shuffle();
    final List<Flight> flightsEat = getFlights(Category.findTrips)..shuffle();

    List<Flight> flights;
    switch (listIndex) {
      case 0:
        flights = flightsFly;
        break;
      case 1:
        flights = flightsSleep;
        break;
      case 2:
        flights = flightsEat;
        break;
    }
    return List.generate(flights.length, (int index) {
      return _DestinationCard(flight: flights[index]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildFlightCards(listIndex: index));
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
  static const List<double> _midHeights = [271.0, 206.0, 271.0];
  static const List<double> _topHeights = [0.0, 0.0, 0.0];

  List<double> _tabHeights = _midHeights;

  TabController _tabController;
  Animation<Offset> _flyLayerOffset;
  Animation<Offset> _sleepLayerOffset;
  Animation<Offset> _eatLayerOffset;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _flyLayerOffset = Tween<Offset>(
        begin: Offset(0.0, 0.0),
        end: Offset(-1.05, 0.0)
    ).animate(_tabController.animation);

    _sleepLayerOffset = Tween<Offset>(
      // Extra .05 leaves a gap between left and right layers.
      begin: Offset(1.05, 0.0),
      end: Offset(0, 0.0),
    ).animate(_tabController.animation);

    _eatLayerOffset = Tween<Offset>(
      begin: Offset(2.0, 0.0),
      end: Offset(1.0, 0.0),
    ).animate(_tabController.animation);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabs(int tabIndex) {
    if (_tabController.index == tabIndex) {
      setState(() {
        _tabHeights = _tabHeights == _topHeights ? _midHeights : _topHeights;
      });
    }
    else {
      _tabController.animateTo(tabIndex, duration: Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: kCranePurple800,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0.0,
          titleSpacing: 0.0,
          flexibleSpace: CraneAppBar(
            tabController: _tabController,
            tabHandler: _handleTabs,
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackLayer(
                tabController: _tabController,
                backLayers: widget.backLayer,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: _tabHeights[0]),
              child: SlideTransition(
                position: _flyLayerOffset,
                child: _FrontLayer(
                  title: 'Explore Flights by Destination',
                  index: 0,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: _tabHeights[1]),
              child: SlideTransition(
                position: _sleepLayerOffset,
                child: _FrontLayer(
                  title: 'Explore Properties by Destination',
                  index: 1,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: _tabHeights[2]),
              child: SlideTransition(
                position: _eatLayerOffset,
                child: _FrontLayer(
                  title: 'Explore Restaurants by Destination',
                  index: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackLayer extends StatefulWidget {
  final List<Widget> backLayers;
  final TabController tabController;

  const BackLayer({ Key key, this.backLayers, this.tabController }) : super(key: key);

  @override
  _BackLayerState createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: widget.backLayers[widget.tabController.index],
      duration: Duration(milliseconds: 300),
    );
  }
}


class CraneAppBar extends StatefulWidget {
  final Function(int) tabHandler;
  final TabController tabController;

  const CraneAppBar({ Key key, this.tabHandler, this.tabController }) : super(key: key);

  @override
  _CraneAppBarState createState() => _CraneAppBarState();
}

class _CraneAppBarState extends State<CraneAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _SplashOverride(
            color: kCraneAlpha,
            child: Container(
              child: IconButton(
                iconSize: 72.0,
                padding: EdgeInsets.all(0.0),
                icon: Image.asset(
                  'assets/menu_logo.png',
                  fit: BoxFit.cover,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            width:  MediaQuery.of(context).size.width - 72.0,
            child: _SplashOverride(
              color: Colors.transparent,
              child: TabBar(
                indicator: BorderTabIndicator(),
                controller: widget.tabController,
                labelPadding: EdgeInsets.all(0.0),
                tabs: <Widget>[
                  _NavigationTab(
                    title: 'FLY',
                    callBack: () => widget.tabHandler(0),
                    tabController: widget.tabController,
                    index: 0,
                  ),
                  _NavigationTab(
                    title: 'SLEEP',
                    callBack: () => widget.tabHandler(1),
                    tabController: widget.tabController,
                    index: 1,
                  ),
                  _NavigationTab(
                    title: 'EAT',
                    callBack: () => widget.tabHandler(2),
                    tabController: widget.tabController,
                    index: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationTab extends StatefulWidget {
  final String title;
  final Function callBack;
  final TabController tabController;
  final int index;

  const _NavigationTab({
    Key key,
    this.title,
    this.callBack,
    this.tabController,
    this.index
  }) : super(key: key);

  @override
  _NavigationTabState createState() => _NavigationTabState();
}

class _NavigationTabState extends State<_NavigationTab> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    widget.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.button.copyWith(
            color: widget.tabController.index == widget.index
                ? kCranePrimaryWhite
                : kCranePrimaryWhite.withOpacity(.6),
          ),
        ),
        onPressed: widget.callBack,
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  _DestinationCard({ this.flight }) : assert(flight != null);
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
          contentPadding: EdgeInsets.only(right: 8.0),
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
            style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.black),
          ),
          subtitle: Text(
            flight.layover ? 'Layover' : 'Nonstop',
            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 12.0),
          ),
        ),
        SizedBox(child: Divider(indent: 4.0)),
      ],
    );
  }
}

class _SplashOverride extends StatelessWidget {
  const _SplashOverride({ Key key, this.color, this.child }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}
