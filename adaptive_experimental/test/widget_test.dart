// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adaptive_starter/main.dart';

const _desktopSize = Size(700, 700);
const _mobileSize = Size(500, 500);

void main() {
  for (final size in [_desktopSize, _mobileSize]) {
    final testName = 'Adaptive navigation rail behaves correctly under $size';
    testWidgets(testName, (WidgetTester tester) async {
      final devicePixelRatio = tester.binding.window.devicePixelRatio;

      tester.binding.window.physicalSizeTestValue = size * devicePixelRatio;
      await tester.pumpWidget(MyApp());

      await tester.tap(find.text('Regular'));
      await tester.pump();

      expect(find.byIcon(Icons.favorite_border), findsNWidgets(4));
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is Icon &&
          widget.icon == Icons.favorite), findsOneWidget);
      // expect(find.text('First'), findsNothing);

    });
  }
}
