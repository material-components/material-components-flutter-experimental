import 'package:flutter/material.dart';

import 'package:theme_generator/data/theme_options.dart';
import 'package:theme_generator/pages/user_interface/home_interface.dart';

class UserInterface extends StatelessWidget {
  final PageController controller = PageController(
    initialPage: 0,
  );

  final List<Widget> pages = [
    Page(
      currentPage: 1,
      child: HomeInterface(),
    ),
    Page(
      currentPage: 2,
      child: Container(
        color: Colors.red,
      ),
    ),
    Page(
      currentPage: 3,
      child: Container(
        color: Colors.blue,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InheritedPageController(
      controller: controller,
      totalPages: pages.length,
      child: PageView(
        controller: controller,
        children: pages,
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    @required this.currentPage,
    @required this.child,
  })  : assert(currentPage != null),
        assert(child != null);

  final Widget child;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageChanger(currentPage: currentPage),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            width: 450,
            child: MaterialApp(
              theme: ThemeOptions.of(context).lightThemeData,
              darkTheme: ThemeOptions.of(context).darkThemeData,
              themeMode: ThemeOptions.of(context).themeMode,
              home: child,
            ),
          ),
        ),
      ],
    );
  }
}

class PageChanger extends StatelessWidget {
  const PageChanger({
    this.currentPage,
  }) : assert(currentPage != null);

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    Duration pageChangeDuration = Duration(microseconds: 100);
    Curve pageCurve = Curves.ease;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: currentPage == 1 ? Colors.grey.shade200 : Colors.black,
            ),
            onPressed: currentPage == 1
                ? null
                : () =>
                    InheritedPageController.of(context).controller.previousPage(
                          duration: pageChangeDuration,
                          curve: pageCurve,
                        )),
        Text(
            '$currentPage \/ ${InheritedPageController.of(context).totalPages}'),
        IconButton(
            icon: Icon(Icons.keyboard_arrow_right,
                color: currentPage ==
                        InheritedPageController.of(context).totalPages
                    ? Colors.grey.shade200
                    : Colors.black),
            onPressed: currentPage ==
                    InheritedPageController.of(context).totalPages
                ? null
                : () => InheritedPageController.of(context).controller.nextPage(
                      duration: pageChangeDuration,
                      curve: pageCurve,
                    )),
      ],
    );
  }
}

class InheritedPageController extends InheritedWidget {
  const InheritedPageController({
    @required this.controller,
    @required this.totalPages,
    @required Widget child,
  })  : assert(controller != null),
        assert(totalPages != null),
        assert(child != null),
        super(child: child);

  final PageController controller;
  final int totalPages;

  static InheritedPageController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedPageController>();

  @override
  bool updateShouldNotify(InheritedPageController oldWidget) =>
      oldWidget.controller != controller;
}
