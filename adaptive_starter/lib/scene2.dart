import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Scene2 extends StatefulWidget {
  @override
  _Scene2State createState() => _Scene2State();
}

class _Scene2State extends State<Scene2> {
  int _currentIndex = 2;
  List<bool> _bottomNavigationKindToggleIsSelected = BottomNavigationKind.values
      .map((state) => BottomNavigationKind.Persistent == state)
      .toList();
  BottomNavigationKind _bottomNavigationKind = BottomNavigationKind.Persistent;
  NavigationRailKind _navigationRailKind = NavigationRailKind.Regular;

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
    bool isDesktop = MediaQuery.of(context).size.width > 600;
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
            navigationItems: navigationItems,
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

enum NavigationRailKind {
  Regular,
  Impersistent,
  Persistent,
//  Extended,
}

class NavigationRail extends StatefulWidget {
  NavigationRail({
    this.leading,
    this.extendedLeading,
    this.navigationItems,
    this.actions,
    this.currentIndex,
    this.onNavigationIndexChange,
    this.labelKind = NavigationRailKind.Regular,
    this.labelTextStyle,
    this.labelIconTheme,
    this.selectedLabelTextStyle,
    this.selectedLabelIconTheme,
  });

  final Widget leading;
  final Widget extendedLeading;
  final List<BottomNavigationBarItem> navigationItems;
  final List<Widget> actions;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChange;

  final NavigationRailKind labelKind;
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
//    final extendedLeading = widget.extendedLeading ?? widget.leading;
//    final leading = widget.labelKind == NavigationRailKind.Extended
//        ? extendedLeading
//        : widget.leading;
    final leading = widget.leading;
    return DefaultTextStyle(
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (leading != null)
              SizedBox(
                height: 96,
                width: 72,
                child: Align(
                  alignment: Alignment.center,
                  child: leading,
                ),
              ),
            for (int i = 0; i < widget.navigationItems.length; i++)
              RailItem(
                labelKind: widget.labelKind,
                selected: widget.currentIndex == i,
                icon: widget.currentIndex == i
                    ? widget.navigationItems[i].activeIcon
                    : widget.navigationItems[i].icon,
                title: DefaultTextStyle(
                  style: TextStyle(
                      color: widget.currentIndex == i
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.64)),
                  child: widget.navigationItems[i].title,
                ),
                onTap: () {
                  widget.onNavigationIndexChange(i);
                },
              ),
            Spacer(),
            ...widget.actions,
          ],
        ),
      ),
    );
  }
}

class RailItem extends StatelessWidget {
  RailItem({this.labelKind, this.selected, this.icon, this.title, this.onTap});

  final NavigationRailKind labelKind;
  final bool selected;
  final Icon icon;
  final Widget title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (labelKind) {
      case NavigationRailKind.Regular:
        content = SizedBox(width: 72, child: icon);
        break;
      case NavigationRailKind.Impersistent:
        content = SizedBox(
          width: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              if (selected) title,
            ],
          ),
        );
        break;
      case NavigationRailKind.Persistent:
        content = SizedBox(
          width: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              title,
            ],
          ),
        );
        break;
    }

    final colors = Theme.of(context).colorScheme;

    return IconTheme(
      data: IconThemeData(
        color: selected ? colors.primary : colors.onSurface.withOpacity(0.64),
      ),
      child: SizedBox(
        height: 72,
        child: Material(
          type: MaterialType.transparency,
          clipBehavior: Clip.none,
          child: InkResponse(
            onTap: onTap,
            onHover: (_) { },
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
            hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
            child: content,
          ),
        ),
      ),
    );
  }
}