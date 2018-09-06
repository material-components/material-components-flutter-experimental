import 'package:flutter/material.dart';

class IconsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IconsPageState();
}

class IconsPageState extends State<IconsPage>
    with SingleTickerProviderStateMixin {
  bool _isSelected = false;
  AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Icons')),
      body: Center(
        child: IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.pause_play,
              progress: _controller.view,
            ),
            iconSize: 100.0,
            onPressed: () {
              _controller.fling(velocity: _isSelected ? -2.0 : 2.0);
              setState(() {
                _isSelected = !_isSelected;
              });
            }),
      ),
    );
  }
}

