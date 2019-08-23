// Copyright 2018-present the Material Components for Flutter authors. All Rights Reserved.
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

import 'bottom_items.dart';
import 'colors.dart';
import 'content.dart' as Content;
import 'notch.dart';
import 'painters.dart';
import 'shape_type.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

enum Layout {
  AppBar,
  Experimental,
  SideFab,
}

class _HomeState extends State<Home> {
  Color _selectedColor = Colors.white;
  int _selectedIndex = 0;
  Layout _layout = Layout.Experimental;
  ShapeType _selectedShape = ShapeType.Cut;

  Color get _strokeColor => _selectedColor == blue500 ? Colors.white : null;

  FloatingActionButton _traditionalFab(onTap) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: Image.asset('assets/icon.png'),
      onPressed: onTap,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setSelectedTile(ShapeType value) {
    setState(() {
      _selectedShape = value;
    });
  }

  void _setSelectedColorTile(Color value) {
    setState(() {
      _selectedColor = value;
    });
  }

  void _setLayout(Layout value) {
    setState(() {
      _layout = value;
    });
  }

  List<Widget> _itemOptions() {
    return [
      BottomNavItem(
        icon: Icons.inbox,
        isSelected: _selectedIndex == 0,
        title: 'Inbox',
        onTap: () {
          _onItemTapped(0);
        },
      ),
      BottomNavItem(
        icon: Icons.star,
        isSelected: _selectedIndex == 1,
        title: 'Starred',
        onTap: () {
          _onItemTapped(1);
        },
      ),
      SizedBox(width: 38),
      BottomNavItem(
        icon: Icons.send,
        isSelected: _selectedIndex == 2,
        title: 'Sent',
        onTap: () {
          _onItemTapped(2);
        },
      ),
      BottomNavItem(
        icon: Icons.archive,
        isSelected: _selectedIndex == 3,
        title: 'Archived',
        onTap: () {
          _onItemTapped(3);
        },
      )
    ];
  }

  Widget _experimentalBottomNav() {
    PlusPainter plusPainter;
    switch (_selectedShape) {
      case ShapeType.Bump:
        plusPainter = PlusPainter(color: _strokeColor, yOffset: 36);
        break;
      case ShapeType.Cut:
        plusPainter = PlusPainter(color: _strokeColor, yOffset: 24);
        break;
      case ShapeType.Flat:
        plusPainter = PlusPainter(color: _strokeColor, iconSize: 24, yOffset: 62);
        break;
    }

    return GestureDetector(
      onTap: () {
        _onFabTap();
      },
      child: CustomPaint(
        foregroundPainter: plusPainter,
        painter: ContainerPainter(
          fillColor: _selectedColor,
          strokeColor: _strokeColor,
          shape: _selectedShape,
        ),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 92),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 46),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _itemOptions(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBar() {
    return BottomAppBar(
      shape: GoogleBabShape(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
      ),
    );
  }

  Widget _bottomNavSideFab() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          title: Text('Inbox'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text('Starred'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send),
          title: Text('Sent'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive),
          title: Text('Archived'),
        ),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: blue500,
      unselectedItemColor: grey600,
      currentIndex: _selectedIndex,
      elevation: 5,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
    );
  }

  void _onFabTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                elevation: 0,
                iconTheme: IconThemeData(color: grey800),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: false,
                        hintText: 'To',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: false,
                        hintText: 'Subject',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: false,
                        hintText: 'Compose email',
                      ),
                      maxLines: 10,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              extendBody: true,
            );
          },
          fullscreenDialog: true,
        ));
  }


  List<Widget> _drawerOptions() {
    return [
      Text('Options', style: Theme.of(context).textTheme.display1),
      Divider(),
      ListTile(title: Text('Shape')),
      RadioListTile(
        title: Text('Flat'),
        value: ShapeType.Flat,
        groupValue: _selectedShape,
        onChanged: _setSelectedTile,
      ),
      RadioListTile(
        title: Text('Bump'),
        value: ShapeType.Bump,
        groupValue: _selectedShape,
        onChanged: _setSelectedTile,
      ),
      RadioListTile(
        title: Text('Cut'),
        value: ShapeType.Cut,
        groupValue: _selectedShape,
        onChanged: _setSelectedTile,
      ),
      ListTile(title: Text('FAB Color')),
      RadioListTile(
        title: Text('White'),
        value: Colors.white,
        groupValue: _selectedColor,
        onChanged: _setSelectedColorTile,
      ),
      RadioListTile(
        title: Text('Blue'),
        value: blue500,
        groupValue: _selectedColor,
        onChanged: _setSelectedColorTile,
      ),
      ListTile(title: Text('Layout')),
      RadioListTile(
          value: Layout.Experimental,
          title: Text('Experimental'),
          groupValue: _layout,
          onChanged: _setLayout,
      ),
      RadioListTile(
          value: Layout.SideFab,
          title: Text('Side FAB'),
          groupValue: _layout,
          onChanged: _setLayout,
      ),
      RadioListTile(
          value: Layout.AppBar,
          groupValue: _layout,
          title: Text('AppBar'),
          onChanged: _setLayout,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    Widget bottomNavWidget;
    switch (_layout) {
      case Layout.AppBar:
        bottomNavWidget = _bottomAppBar();
        break;
      case Layout.Experimental:
        bottomNavWidget = _experimentalBottomNav();
        break;
      case Layout.SideFab:
        bottomNavWidget = _bottomNavSideFab();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: grey800),
        title: const Text(
          'Messages',
          style: TextStyle(
            color: red500,
          ),
        ),
      ),
      body: Content.navigationViews.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavWidget,
      drawer: Drawer(
        child: SafeArea(
          child: ListView(children: _drawerOptions()),
        ),
      ),
      extendBody: true,
      floatingActionButton: _layout != Layout.Experimental
          ? _traditionalFab(() {
              _onFabTap();
            })
          : null,
      floatingActionButtonLocation: _layout == Layout.AppBar
          ? FloatingActionButtonLocation.centerDocked
          : null,
    );
  }
}
