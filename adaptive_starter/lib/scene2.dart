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
    bool isDesktop = true;
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
        color: Theme.of(context).colorScheme.primary,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        child: Container(
          padding: EdgeInsets.all(8),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: <Widget>[
              for (int i = 0; i < widget.navigationItems.length; i++)
                RailItem(
                  labelState: widget.labelState,
                  selected: widget.currentIndex == i,
                  icon: widget.navigationItems[i].icon,
                  title: widget.navigationItems[i].title,
                  onTap: () {
                    widget.onNavigationIndexChange(i);
                  },
                ),
              Spacer(),
              ...widget.actions,
            ],
          ),
        ),
      ),
    );
  }
}

class RailItem extends StatelessWidget {
  RailItem({this.labelState, this.selected, this.icon, this.title, this.onTap});

  final NavigationRailLabelState labelState;
  final bool selected;
  final Icon icon;
  final Widget title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (labelState) {
      case NavigationRailLabelState.None:
        content = icon;
        break;
      case NavigationRailLabelState.Impersistent:
        content = Column(
          children: <Widget>[
            icon,
            title,
          ],
        );
        break;
      case NavigationRailLabelState.Persistent:
        content = Column(
          children: <Widget>[
            icon,
            title,
          ],
        );
        break;
      case NavigationRailLabelState.Extended:
        content = Column(
          children: <Widget>[
            icon,
            title,
          ],
        );
        break;
    }

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
