import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/demos/radical_slider_demo.dart';

class BottomNavDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavDemoState();
}

class BottomNavDemoState extends State<BottomNavDemo> {
  bool _showLabels = true;
  int _selectedIndex = 0;
  final _widgetOptions = [
    Text('Pictures of Cats'),
    Text('Pictures of Dogs'),
    Text('Pictures of People'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('BottomNavigationBar Sample'),
        actions: <Widget>[
          Switch(value: _showLabels, onChanged: (bool newValue) {
            setState(() {
              _showLabels = newValue;
            });
          })
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: _showLabels,
        showUnselectedLabels: _showLabels,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces),
            title: Text('Cats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            title: Text('Dogs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('People'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
    ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
