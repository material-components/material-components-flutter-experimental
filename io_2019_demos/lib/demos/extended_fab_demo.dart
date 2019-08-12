import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExtendedFabDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExtendedFabDemoState();
}

class ExtendedFabDemoState extends State<ExtendedFabDemo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Dog'),
      ),
      body: Center(
        child: Image.asset('assets/dog5.jpg'),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        // define context of Navigator.push()
        return FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Tap to go to the wolf screen'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    title: Text('Wolf'),
                  ),
                  floatingActionButton: new FloatingActionButton.extended(
                    backgroundColor: Color(0x0ff6600dd),
                    icon: const Icon(Icons.add),
                    label: const Text('Cool'),
                    onPressed: () {},
                  ),
                  body: Center(
                    child: Image.asset('assets/dog2.jpg'),
                  ),
                );
              },
            ));
          },
        );
      }),
    );
  }
}
