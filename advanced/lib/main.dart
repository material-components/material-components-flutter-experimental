import 'package:flutter/material.dart';
import 'home.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Shrine/model/app_state_model.dart';


void main() {
  AppStateModel model = AppStateModel();
  model.loadProducts();

  runApp(
    ScopedModel<AppStateModel>(
      model: model,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primaryColor: kPlainPurple,
          textTheme: Theme.of(context).textTheme.copyWith(
              display1: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(color: Colors.black))),
      home: new MainHomePage(),
    );
  }
}

const kPlainPurple = Color(0xFF6200EE);