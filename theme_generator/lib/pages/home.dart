import 'package:flutter/material.dart';
import 'package:theme_generator/data/theme_options.dart';
//import 'package:theme_generator/pages/color_picker.dart';
import 'package:theme_generator/pages/material_palette.dart';
import 'package:theme_generator/pages/current_scheme.dart';
import 'package:theme_generator/pages/user_interface.dart';
import 'package:theme_generator/pages/type_scale.dart';
import 'package:theme_generator/pages/fonts.dart';
import 'package:theme_generator/pages/shapes.dart';
import 'package:theme_generator/pages/code.dart';
import 'package:dart_code_viewer/dart_code_viewer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Maybe use Sliver app Bar
      appBar: AppBar(
        title: Text('Theme Generator'),
        elevation: 1,
        actions: [
          FlatButton(
            onPressed: () {
              print(ThemeOptions.of(context).themeMode);
              ThemeOptions.of(context).toggleThemeMode(context);
            },
            child: Text(ThemeOptions.of(context).themeMode == ThemeMode.light
                ? 'Light Theme'
                : 'Dark Theme'),
          ),

          ///TODO: Download material_theme.dart
          FlatButton(
            onPressed: null,
            child: Text('EXPORT'),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey.shade400),
                ),
//                color: ,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Template(
                        tabs: [
                          Tab(text: 'USER INTERFACES'),
                          Tab(text: 'ACCESSIBILITY'),
                          Tab(text: 'DARTPAD'),
                          Tab(text: 'APP THEME DATA'),
                        ],
                        pages: [
//                          AppThemeData(),
                          UserInterface(),
                          Container(color: Colors.transparent),
                          Container(color: Colors.transparent),
                          DartCodeViewer(ThemeOptions.of(context).toString()),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.feedback),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => _FeedbackDialog());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Template(
                    tabs: [
                      Tab(text: 'MATERIAL PALETTES'),
                      Tab(text: 'FONTS'),
                      Tab(text: 'TYPE SCALE'),
                      Tab(text: 'SHAPES'),
                      Tab(text: 'CUSTOM'),
                      Tab(text: 'CODE'),
                    ],
                    pages: [
                      MaterialPalette(),
//                      TypeScale(),
                      Fonts(),
                      TypeScale(),
                      Shapes(),
                      Container(color: Colors.pink),
                      Code(),

                      /// Does not work for Flutter for Web
//                      CircleColorPicker(
//                        initialColor: Colors.blue,
//                        onChanged: (color) => print(color),
//                        size: const Size(240, 240),
//                        strokeWidth: 4,
//                        thumbSize: 36,
//                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Template(
                    tabs: [
                      Tab(text: 'CURRENT SCHEME'),
                    ],
                    pages: [
                      CurrentScheme(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Send Feedback'),
    );
  }
}

class Template extends StatelessWidget {
  const Template({
    this.tabs,
    this.pages,
  })  : assert(tabs != null),
        assert(tabs.length == pages.length);

  final List<Tab> tabs;
  final List<Widget> pages;

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          flexibleSpace: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                isScrollable: true,
                tabs: tabs,
              ),
            ],
          ),
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
