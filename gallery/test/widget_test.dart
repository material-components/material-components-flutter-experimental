import 'package:flutter_test/flutter_test.dart';

import 'package:gallery/main.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Material'), findsOneWidget);
  });
}
