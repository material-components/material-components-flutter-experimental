import 'package:flutter/material.dart' hide NavigationRail;
import 'package:flutter/widgets.dart';

import 'navigation_rail.dart';

class Scene2 extends StatefulWidget {
  @override
  _Scene2State createState() => _Scene2State();
}

class _Scene2State extends State<Scene2> {
  int _currentIndex = 2;
  List<bool> _bottomNavigationKindToggleIsSelected = BottomNavigationKind.values
      .map((state) => BottomNavigationKind.Impersistent == state)
      .toList();
  BottomNavigationKind _bottomNavigationKind = BottomNavigationKind.Impersistent;
  NavigationRailKind _navigationRailKind = NavigationRailKind.Impersistent;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: Text('Scene'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Kind'),
            SizedBox(height: 20),
            ToggleButtons(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Center(child: Text('Regular')),
                ),
                SizedBox(
                  width: 100,
                  child: Center(child: Text('Impersistent')),
                ),
                SizedBox(
                  width: 100,
                  child: Center(child: Text('Persistent')),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                  buttonIndex <
                      _bottomNavigationKindToggleIsSelected.length;
                  buttonIndex++) {
                    if (buttonIndex == index) {
                      _bottomNavigationKindToggleIsSelected[buttonIndex] = true;
                    } else {
                      _bottomNavigationKindToggleIsSelected[buttonIndex] =
                      false;
                    }
                  }
                  _bottomNavigationKind = BottomNavigationKind.values[index];
                  _navigationRailKind = NavigationRailKind.values[index];
                });
              },
              isSelected: _bottomNavigationKindToggleIsSelected,
            ),
            SizedBox(height: 40),
            Text('Item Index'),
            SizedBox(height: 20),
            Text(
              _currentIndex.toString(),
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
//      actions: [
//        SizedBox(
//          height: 48,
//          child: IconButton(
//            icon: Icon(Icons.search),
//            onPressed: () {},
//          ),
//        ),
//        SizedBox(
//          height: 48,
//          child: IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () {},
//          ),
//        ),
//      ],
      actions: [],
      navigationItems: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          title: Text('First'),
          backgroundColor: Color(0xFF6200EE),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          title: Text('Second'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          title: Text('Third'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          title: Text('Fourth'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          title: Text('Fifth'),
        )
      ],
      currentIndex: _currentIndex,
      onNavigationIndexChange: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      navigationRailKind: _navigationRailKind,
      bottomNavigationKind: _bottomNavigationKind,
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      extendedFloatingActionButton: FloatingActionButton.extended(
        elevation: 3,
        icon: Icon(Icons.add),
        label: Text('CREATE'),
        onPressed: () {},
      ),
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
    this.navigationRailKind,
    this.bottomNavigationKind,
    this.floatingActionButton,
    this.extendedFloatingActionButton,
  });

  final Widget title;
  final Widget body;
  final List<Widget> actions;
  final List<BottomNavigationBarItem> navigationItems;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChange;

  final NavigationRailKind navigationRailKind;
  final BottomNavigationKind bottomNavigationKind;
  final Widget floatingActionButton;
  final Widget extendedFloatingActionButton;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context)!.size.width > 600;
    return isDesktop
        ? Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
//              leading: Icon(Icons.menu),
//            leading: SizedBox(),
        title: title,
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            leading: floatingActionButton,
            extendedLeading: extendedFloatingActionButton,
            items: navigationItems,
            actions: actions,
            currentIndex: currentIndex,
            onNavigationIndexChange: onNavigationIndexChange,
            labelKind: navigationRailKind,
          ),
          Expanded(child: body),
        ],
      ),
    )
        : Scaffold(
      floatingActionButton: floatingActionButton,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: title,
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onNavigationIndexChange,
        backgroundColor: Color(0xFF6200EE),
        unselectedItemColor: Colors.white.withOpacity(0.75),
        selectedItemColor: Colors.white,
        items: navigationItems,
        showSelectedLabels:
        bottomNavigationKind != BottomNavigationKind.Regular,
        showUnselectedLabels:
        bottomNavigationKind == BottomNavigationKind.Persistent,
      ),
    );
  }
}

enum BottomNavigationKind {
  Regular,
  Impersistent,
  Persistent,
}