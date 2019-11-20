## [0.0.2] - 2019-11-20

Update README with import instructions.

## [0.0.1] - 2019-11-15

The initial release supports all 960 fonts and variants from fonts.google.com.

ttf files are downloaded via http on demand, and saved to local disk so that they can be loaded
without making another http request for future font requests. Fonts are loaded asynchronously 
through the font loader and Text widgets that use them are refreshed when they are ready.
