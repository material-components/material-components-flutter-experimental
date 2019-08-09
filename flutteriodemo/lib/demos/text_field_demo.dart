import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/demos/radical_slider_demo.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TextFieldDemoState();
}

class TextFieldDemoState extends State<TextFieldDemo> {
  double _hueValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
                child: TextField(
                  maxLines: 4,
                  minLines: 2,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  cursorColor: HSLColor.fromAHSL(1, _hueValue, 1, 0.5).toColor(),
                  cursorWidth: 4,
                  cursorRadius: Radius.circular(30),
                ),
              ),
              SizedBox(height: 16),
              SliderTheme(
                data: buildHueSelectorSliderThemeData(context),
                child: Slider(
                  value: _hueValue,
                  min: 0,
                  max: 360,
                  onChanged: (double value) {
                    setState(() {
                      _hueValue = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Input Action Example',
                ),
                textInputAction: TextInputAction.go,
              )
            ],
          ),
        ),
      ),
    );
  }
}