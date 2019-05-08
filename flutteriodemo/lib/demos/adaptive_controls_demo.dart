import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdaptiveControlsDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdaptiveControlsDemoState();
}

class AdaptiveControlsDemoState extends State<AdaptiveControlsDemo> {
  bool _switchValue = true;
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch.adaptive(
                value: _switchValue,
                onChanged: (bool newValue) {
                  setState(() {
                    _switchValue = newValue;
                  });
                },
            ),
            SizedBox(height: 100),
            Slider.adaptive(
              value: _sliderValue,
              onChanged: (double newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              }
            ),
          ],
        ),
      ),
    );
  }
}