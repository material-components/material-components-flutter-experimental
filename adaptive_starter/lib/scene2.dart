import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Scene2 extends StatefulWidget {
  @override
  _Scene2State createState() => _Scene2State();
}

class _Scene2State extends State<Scene2> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: Text('Scene 2'),
      body: Center(
        child: Text(
          _currentIndex.toString(),
          style: TextStyle(fontSize: 24),
        ),
      ),
      actions: [
        SizedBox(
          height: 48,
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: 48,
          child: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ),
      ],
      navigationItems: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Favorite'),
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          title: Text('Inbox'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send),
          title: Text('Send'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Text('Settings'),
        )
      ],
      currentIndex: _currentIndex,
      onNavigationIndexChange: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

class AdaptiveScaffold extends StatelessWidget {
  AdaptiveScaffold({
    Key key,
    this.title,
    this.body,
    this.actions,
    this.navigationItems,
    this.currentIndex,
    this.onNavigationIndexChange,
  });

  final Widget title;
  final Widget body;
  final List<Widget> actions;
  final List<BottomNavigationBarItem> navigationItems;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChange;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = false;
    return isDesktop
        ? Scaffold(
            body: Row(
              children: <Widget>[
                NavigationRail(
                  navigationItems: navigationItems,
                  actions: actions,
                  currentIndex: currentIndex,
                  onNavigationIndexChange: onNavigationIndexChange,
                ),
                Expanded(child: body),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: title,
              actions: actions,
            ),
            body: body,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: onNavigationIndexChange,
              backgroundColor: Colors.blue,
              unselectedItemColor: Colors.white.withOpacity(0.75),
              selectedItemColor: Colors.white,
              items: navigationItems,
            ),
          );
  }
}

enum NavigationRailLabelState {
  None,
  Impersistent,
  Persistent,
  Extended,
}

class NavigationRail extends StatefulWidget {
  NavigationRail({
    this.navigationItems,
    this.actions,
    this.currentIndex,
    this.onNavigationIndexChange,
    this.labelState,
    this.labelTextStyle,
    this.labelIconTheme,
    this.selectedLabelTextStyle,
    this.selectedLabelIconTheme,
  });

  final List<BottomNavigationBarItem> navigationItems;
  final List<Widget> actions;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChange;

  final NavigationRailLabelState labelState;
  final TextStyle labelTextStyle;
  final IconTheme labelIconTheme;
  final TextStyle selectedLabelTextStyle;
  final IconTheme selectedLabelIconTheme;

  @override
  _NavigationRailState createState() => _NavigationRailState();
}

class _NavigationRailState extends State<NavigationRail> {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        color: Colors.white,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Container(
          padding: EdgeInsets.all(8),
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            children: <Widget>[
              for (int i = 0; i < widget.navigationItems.length; i++)
                RailItem(
                  selected: widget.currentIndex == i,
                  icon: widget.navigationItems[i].icon,
                  title: widget.navigationItems[i].title,
                  onTap: () {
                    widget.onNavigationIndexChange(i);
                  },
                ),
              Spacer(),
              for (final action in widget.actions) action
            ],
          ),
        ),
      ),
    );
  }
}

class RailItem extends StatelessWidget {
  RailItem({this.selected, this.icon, this.title, this.onTap});

  final bool selected;
  final Icon icon;
  final Widget title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
          height: 60,
          child: Column(
            children: <Widget>[
              icon,
              title,
            ],
          )),
    );
  }
}
