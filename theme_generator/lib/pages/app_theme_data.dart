import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_generator/theme_app.dart';
import 'package:theme_generator/data/theme_options.dart';
import 'package:theme_generator/pages/codeviewer/code_style.dart';
import 'package:theme_generator/pages/codeviewer/prehighlighter.dart';
import 'package:theme_generator/theme_app.dart';

class AppThemeData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: _DemoSectionCode(
        maxHeight: MediaQuery.of(context).size.height,
        codeWidget: CodeDisplayPage(
          codifyString(ThemeOptions.of(context).toString(), context),
        ),
      ),
    );
  }
}

class _DemoSectionCode extends StatelessWidget {
  const _DemoSectionCode({
    Key key,
    this.maxHeight,
    this.codeWidget,
  }) : super(key: key);

  final double maxHeight;
  final Widget codeWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: maxHeight,
        child: codeWidget,
      ),
    );
  }
}

class CodeDisplayPage extends StatelessWidget {
  const CodeDisplayPage(this.code);

  final InlineSpan code;

  @override
  Widget build(BuildContext context) {
    final _richTextCode = code;
    final _plainTextCode = _richTextCode.toPlainText();

    void _showSnackBarOnCopySuccess(dynamic result) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Copied to Clipboard'),
        ),
      );
    }

    void _showSnackBarOnCopyFailure(Object exception) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Failure to copy to clipboard: $exception'),
        ),
      );
    }

    return ListView(
      children: [
        FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(
              text: _plainTextCode,
            ))
                .then(_showSnackBarOnCopySuccess)
                .catchError(_showSnackBarOnCopyFailure);
          },
          child: Text('COPY ALL'),
        ),
        SingleChildScrollView(
          child: RichText(
            textDirection: TextDirection.ltr,
            text: _richTextCode,
          ),
        ),
      ],
    );
  }
}

TextSpan stringToTextSpan(String string, BuildContext context) {
  return TextSpan(
    style: () {
      String styleString = RegExp(r'codeStyle.\w*').firstMatch(string).group(0);
      CodeStyle codeStyle = themeBasedCodeStyle(context);
      switch (styleString) {
        case 'codeStyle.baseStyle':
          return codeStyle.baseStyle;
        case 'codeStyle.numberStyle':
          return codeStyle.numberStyle;
        case 'codeStyle.commentStyle':
          return codeStyle.commentStyle;
        case 'codeStyle.keywordStyle':
          return codeStyle.keywordStyle;
        case 'codeStyle.stringStyle':
          return codeStyle.stringStyle;
        case 'codeStyle.punctuationStyle':
          return codeStyle.punctuationStyle;
        case 'codeStyle.classStyle':
          return codeStyle.classStyle;
        case 'codeStyle.constantStyle':
          return codeStyle.constantStyle;
        default:
          return codeStyle.baseStyle;
      }
    }(),
    text: () {
      String textString = RegExp('\'.*\'').firstMatch(string).group(0);
      String subString = textString.substring(1, textString.length - 1);
      return decodeString(subString);
    }(),
  );
}

/// Read rawa string as regular String. Converts Unicode characters to actual
/// numbers.
String decodeString(String string) {
  return string
      .replaceAll(r'\u000a', '\n')
      .replaceAll(r'\u0027', '\''.replaceAll(r'\u009', '\t'));
}

InlineSpan codifyString(String content, BuildContext context) {
  List<TextSpan> textSpans = [];
  final codeSpans = DartSyntaxPrehighlighter().format(content);

  for (final span in codeSpans) {
    textSpans.add(stringToTextSpan(span.toString(), context));
  }

  return TextSpan(children: textSpans);
}

final codeTheme = GoogleFonts.robotoMono(
  fontSize: 12,
);

/// Create codeStyle for both LightMode and DarkMode. This data should be
/// generated from the ThemeData.
CodeStyle themeBasedCodeStyle(BuildContext context) {
  if (ThemeOptions.of(context).themeMode == ThemeMode.light) {
    return CodeStyle(
      baseStyle: codeTheme.copyWith(color: Colors.black),
      numberStyle: codeTheme.copyWith(color: Colors.blue),
      commentStyle: codeTheme.copyWith(color: const Color(0xFF808080)),
      keywordStyle: codeTheme.copyWith(color: Colors.blue.shade800),
      stringStyle: codeTheme.copyWith(color: const Color(0xFFFFA65C)),
      punctuationStyle: codeTheme.copyWith(color: Colors.orange.shade800),
      classStyle: codeTheme.copyWith(color: Colors.pink.shade800),
      constantStyle: codeTheme.copyWith(color: const Color(0xFFFF8383)),
    );
  } else if (ThemeOptions.of(context).themeMode == ThemeMode.dark) {
    return CodeStyle(
      baseStyle: codeTheme.copyWith(color: const Color(0xFFFAFBFB)),
      numberStyle: codeTheme.copyWith(color: const Color(0xFFBD93F9)),
      commentStyle: codeTheme.copyWith(color: const Color(0xFF808080)),
      keywordStyle: codeTheme.copyWith(color: const Color(0xFF1CDEC9)),
      stringStyle: codeTheme.copyWith(color: const Color(0xFFFFA65C)),
      punctuationStyle: codeTheme.copyWith(color: const Color(0xFF8BE9FD)),
      classStyle: codeTheme.copyWith(color: const Color(0xFFD65BAD)),
      constantStyle: codeTheme.copyWith(color: const Color(0xFFFF8383)),
    );
  } else {
    return CodeStyle(
      baseStyle: codeTheme.copyWith(color: Colors.black),
      numberStyle: codeTheme.copyWith(color: Colors.blue),
      commentStyle: codeTheme.copyWith(color: const Color(0xFF808080)),
      keywordStyle: codeTheme.copyWith(color: Colors.blue.shade800),
      stringStyle: codeTheme.copyWith(color: const Color(0xFFFFA65C)),
      punctuationStyle: codeTheme.copyWith(color: Colors.orange.shade800),
      classStyle: codeTheme.copyWith(color: Colors.pink.shade800),
      constantStyle: codeTheme.copyWith(color: const Color(0xFFFF8383)),
    );
  }
}
