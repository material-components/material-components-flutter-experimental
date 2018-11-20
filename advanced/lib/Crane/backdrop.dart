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
    return Material(
        elevation: 16.0,
        color: kCranePrimaryWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.display1),
            SizedBox(height: 8.0),
            Column(children: _buildFlightCards(listIndex: index)),
          ],
        ),
    );
  }

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
  static const List<double> _tabHeights = [236.0, 176.0, 236.0];

  TabController _tabController;
  bool _isOpen = true;
  double _openHeight = _tabHeights[0];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      final int value = _tabController.index;
      if (_tabHeights[value] != _openHeight) {
        setState(() {
          _openHeight = _tabHeights[value];
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _handleTabs(var tabIndex) {
      if (_tabController.index == tabIndex) {
        setState(() {
          _isOpen = !_isOpen;
        });
      } else {
        _tabController.animateTo(tabIndex);
      }
    }

    return Material(
      child: Scaffold(
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
            widget.backLayer[0],
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(top: _isOpen ? _openHeight : 0.0),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _FrontLayer(
                      title: 'Explore Flights by Destination',
                      index: 0,
                  ),
                  _FrontLayer(
                      title: 'Explore Properties by Destination',
                      index: 1,
                  ),
                  _FrontLayer(
                      title: 'Explore Restaurants by Destination',
                      index: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CraneAppBar extends StatefulWidget {
  final Function(int) tabHandler;
  final TabController tabController;

  const CraneAppBar({Key key, this.tabHandler, this.tabController}) : super(key: key);

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
                onPressed: () {
                },
              ),
            ),
          ),
          Container(
            height: 100.0,
            width:  MediaQuery.of(context).size.width - 72.0,
            child: _SplashOverride(
              color: Colors.transparent,
              child: TabBar(
                indicator: BorderTabIndicator(),
                controller: widget.tabController,
                tabs: <Widget>[
                  _NavigationTab(title: 'FLY', callBack: () => widget.tabHandler(0)),
                  _NavigationTab(title: 'SLEEP', callBack: () => widget.tabHandler(1)),
                  _NavigationTab(title: 'EAT', callBack: () => widget.tabHandler(2)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationTab extends StatelessWidget {
  final String title;
  final Function callBack;

  const _NavigationTab({ Key key, this.title, this.callBack }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      width: 75.0,
      child: FlatButton(
        child: Text(
          title,
          style: Theme.of(context).textTheme.caption.copyWith(
            color: kCranePrimaryWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        textColor: kCranePrimaryWhite,
        onPressed: callBack,
      ),
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
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            flight.layover ? 'Layover' : 'Nonstop',
            style: Theme.of(context).textTheme.subhead,
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
