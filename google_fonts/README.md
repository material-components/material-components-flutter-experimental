# google_fonts

*** WARNING: This package is experimental and should not be used in production. ***

The GoogleFonts package for Flutter allows you to easily use any of the 960 fonts
(and their variants) from fonts.google.com in your flutter app.

## Getting Started

![](https://raw.githubusercontent.com/material-components/material-components-flutter-experimental/master/google_fonts/main.gif)

With the GoogleFonts package, ttf files do not need to be stored in your assets folder and mapped in
the pubspec. Instead, they are fetched once via http at runtime, and stored in the apps local disk
space. This is ideal for development, and can be the preferred behavior for production apps that
are looking to save space in the initial app bundle size.

First, add the google_fonts package to your pubspec dependencies:

```
dependencies:
  google_fonts: ^0.0.4
```

To import GoogleFonts:

```dart
import 'package:google_fonts/google_fonts.dart';
```

To use google fonts with the default TextStyle:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(),
),
```

To use google fonts with an existing TextStyle:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18)),
),
```

or

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(textStyle: Theme.of(context).textTheme.display1),
),
```

To override the fontWeight and/or fontStyle:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.display1,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  ),
),
```

## What's Next?

In the case where you do want to bundle the ttf for your font in your app's bundle, and still use
this GoogleFonts library, you will be able to additionally store the ttf in your app's assets, and
the GoogleFonts library will defer to that location before fetching from http. This means you will
get the best of both worlds by developing with access to all fonts and using the GoogleFonts library
API, but also pre-bundle the ttf that you want available immediately and without an internet
connection, without having to change any dart code.

This feature will be in a future release.
