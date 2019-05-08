import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/demo.dart';

class IoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: IoDemos.buildDemos().map((IoDemo demo) {
            return SizedBox(
              height: 64,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: demo.routeBuilder,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(child: Text(demo.title), alignment: Alignment.centerLeft),
                ),
              ),
            );
          }).toList(),
        ),
      )
    );
  }
}