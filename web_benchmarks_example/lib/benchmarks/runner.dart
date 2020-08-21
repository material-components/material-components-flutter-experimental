// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_benchmarks_framework/recorder.dart';
import 'package:web_benchmarks_framework/driver.dart';
import 'package:web_benchmarks_example/main.dart';
import 'package:web_benchmarks_example/homepage.dart' show textKey, aboutPageKey;
import 'package:web_benchmarks_example/aboutpage.dart' show backKey;

/// A recorder that measures frame building durations.
class AppRecorder extends WidgetRecorder {
  AppRecorder({@required this.benchmarkName}): super(name: benchmarkName);

  final String benchmarkName;

  bool _completed = false;

  @override
  bool shouldContinue () {
    if (benchmarkName == 'scroll') {
      return profile.shouldContinue();
    } else {
      return profile.shouldContinue() || !_completed;
    }
  }

  @override
  Widget createWidget() {
    final automationFunction = {
      'scroll': automateScrolling,
      'page': automatePaging,
      'tap': automateTapping,
    } [benchmarkName];
    Future.delayed(Duration(milliseconds: 400), automationFunction);
    return MyApp();
  }

  Future<void> automateScrolling() async {
    final scrollable = Scrollable.of(find.byKey(textKey).evaluate().single);
    await scrollable.position.animateTo(
      30000,
      curve: Curves.linear,
      duration: Duration(seconds: 20),
    );
  }

  Future<void> automatePaging() async {
    final controller = LiveWidgetController(WidgetsBinding.instance);
    for (int i = 0; i < 10; ++i) {
      print ('Testing round $i...');
      await controller.tap(find.byKey(aboutPageKey));
      await animationStops();
      await controller.tap(find.byKey(backKey));
      await animationStops();
    }
    _completed = true;
  }

  Future<void> automateTapping() async {
    final controller = LiveWidgetController(WidgetsBinding.instance);
    for (int i = 0; i < 10; ++i) {
      print ('Testing round $i...');
      await controller.tap(find.byIcon(Icons.add));
      await animationStops();
    }
    _completed = true;
  }

  Future<void> animationStops() async {
    while (WidgetsBinding.instance.hasScheduledFrame) {
      await Future<void>.delayed(Duration(milliseconds: 200));
    }
  }
}

Future<void> main () async {
  await runBenchmarks(
    {
      'scroll':
        () => AppRecorder(benchmarkName: 'scroll'),
      'page':
        () => AppRecorder(benchmarkName: 'page'),
      'tap':
        () => AppRecorder(benchmarkName: 'tap'),
    },
  );
}
