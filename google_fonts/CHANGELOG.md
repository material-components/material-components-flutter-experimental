## [0.1.0] - 2019-12-06

### Generated method names changed (breaking change).

For example,

`GoogleFonts.lato(...)` is now `GoogleFonts.latoTextStyle(...)`.

### Text theme support

Every font family now _also_ has a `TextTheme` method.

For example, the `Lato` font now has `GoogleFonts.latoTextStyle()` and `GoogleFonts.latoTextTheme()`.

See README for more examples.

### Other cleanups

Refactored implementation, updated READMEs, and usage docs.


## [0.0.8] - 2019-12-04

Internal refactor and added tests.

## [0.0.7] - 2019-12-04

BETA support for Flutter web.

## [0.0.6] - 2019-12-04

Minor updates to README.

## [0.0.5] - 2019-11-20

Mark as experimental in more places.

## [0.0.4] - 2019-11-20

Add pubspec instructions to README.

## [0.0.3] - 2019-11-20

Fix homepage and main gif.

## [0.0.2] - 2019-11-20

Update README with import instructions.

## [0.0.1] - 2019-11-15

The initial release supports all 960 fonts and variants from fonts.google.com.

ttf files are downloaded via http on demand, and saved to local disk so that they can be loaded
without making another http request for future font requests. Fonts are loaded asynchronously 
through the font loader and Text widgets that use them are refreshed when they are ready.
