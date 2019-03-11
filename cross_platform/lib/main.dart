import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Material on iOS'),
      ),
      body: Center(
        child: OutlineButton(
            child: Text('Push Variances View'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return MaterialOniOS();
              }));
            }),
      ),
    );
  }
}

class MaterialOniOS extends StatefulWidget {
  @override
  MaterialOniOSState createState() {
    return new MaterialOniOSState();
  }
}

class MaterialOniOSState extends State<MaterialOniOS> {
  List<bool> switchValues;
  @override
  void initState() {
    super.initState();
    switchValues = [
      true,
      false,
      false,
      true,
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Material on iOS'),
        bottom: PreferredSize(
          child: Divider(
            height: 0.0,
            color: Colors.black38,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: switchValues.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => SwitchListTile.adaptive(
              value: switchValues[index],
              title: Text('Option ${index + 1}'),
              onChanged: (bool) {
                print('Line x was touched');
              },
            ),
      ),
    );
  }
}
