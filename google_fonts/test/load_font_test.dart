import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/src/google_fonts_base.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  setUp(() async {
    httpClient = MockHttpClient();
    when(httpClient.get(any)).thenAnswer((_) async {
      return http.Response('fake response body - success', 200);
    });

    // The following snippet pulled from
    //  * https://flutter.dev/docs/cookbook/persistence/reading-writing-files#testing
    final directory = await Directory.systemTemp.createTemp();
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });

  tearDown(() {
    clearCache();
  });

  testWidgets(' loadFont method calls http', (tester) async {
    final fakeFont = 'foo';
    final fakeUrl = Uri.http('fonts.google.com', '/foo');

    await loadFont(fakeFont, fakeUrl.toString());

    verify(httpClient.get(fakeUrl)).called(1);
  });

  testWidgets('loadFont method does not make http request on subsequent calls',
      (tester) async {
    final fakeFont = 'foo';
    final fakeUrl = Uri.http('fonts.google.com', '/foo');

    // 1st call.
    await loadFont(fakeFont, fakeUrl.toString());
    verify(httpClient.get(fakeUrl)).called(1);

    // 2nd call.
    await loadFont(fakeFont, fakeUrl.toString());
    verifyNever(httpClient.get(fakeUrl));

    // 3rd call.
    await loadFont(fakeFont, fakeUrl.toString());
    verifyNever(httpClient.get(fakeUrl));
  });

  testWidgets('loadFont method writes font file', (tester) async {
    final fakeFont = 'foo';
    final fakeUrl = Uri.http('fonts.google.com', '/foo');

    var directoryContents = await getApplicationDocumentsDirectory();
    expect(directoryContents.listSync().isEmpty, isTrue);

    await loadFont(fakeFont, fakeUrl.toString());
    directoryContents = await getApplicationDocumentsDirectory();

    expect(directoryContents.listSync().isNotEmpty, isTrue);
    expect(
      directoryContents.listSync().single.toString().contains(fakeFont),
      isTrue,
    );
  });
}
