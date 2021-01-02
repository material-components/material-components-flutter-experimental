import 'package:flutter/material.dart';

class HomeInterface extends StatefulWidget {
  @override
  _HomeInterfaceState createState() => _HomeInterfaceState();
}

class _HomeInterfaceState extends State<HomeInterface> {
  @override
  Widget build(BuildContext context) {
    RangeValues _rangeSliderDiscreteValues = const RangeValues(40, 80);

    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      body: RangeSlider(
        values: _rangeSliderDiscreteValues,
        min: 0,
        max: 100,
        divisions: 5,
        labels: RangeLabels(
          _rangeSliderDiscreteValues.start.round().toString(),
          _rangeSliderDiscreteValues.end.round().toString(),
        ),
        onChanged: (values) {
          setState(() {
            _rangeSliderDiscreteValues = values;
          });
        },
      ),
//    ),
    );
  }
}
