import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_generator/data/theme_options.dart';

class Fonts extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (String key in GoogleFonts.asMap().keys) ...[
          ListTile(
            title: Text(
              key,
              style: GoogleFonts.getFont(key),
            ),
            onTap: () {
              ThemeOptions.update(
                context,
                ThemeOptions.of(context).copyWith(
                  textStyle: GoogleFonts.getFont(key),
                  textFontFamily: key,
                  textTheme: TextTheme(
                    headline1: GoogleFonts.getFont(key),
                    headline2: GoogleFonts.getFont(key),
                    headline3: GoogleFonts.getFont(key),
                    headline4: GoogleFonts.getFont(key),
                    headline5: GoogleFonts.getFont(key),
                    headline6: GoogleFonts.getFont(key),
                    subtitle1: GoogleFonts.getFont(key),
                    subtitle2: GoogleFonts.getFont(key),
                    bodyText1: GoogleFonts.getFont(key),
                    bodyText2: GoogleFonts.getFont(key),
                    caption: GoogleFonts.getFont(key),
                    button: GoogleFonts.getFont(key),
                    overline: GoogleFonts.getFont(key),
                  ),
                  lightThemeData:
                      (ThemeOptions.of(context).lightThemeData ?? ThemeData())
                          .copyWith(
                    textTheme: TextTheme(
                      headline1: GoogleFonts.getFont(key),
                      headline2: GoogleFonts.getFont(key),
                      headline3: GoogleFonts.getFont(key),
                      headline4: GoogleFonts.getFont(key),
                      headline5: GoogleFonts.getFont(key),
                      headline6: GoogleFonts.getFont(key),
                      subtitle1: GoogleFonts.getFont(key),
                      subtitle2: GoogleFonts.getFont(key),
                      bodyText1: GoogleFonts.getFont(key),
                      bodyText2: GoogleFonts.getFont(key),
                      caption: GoogleFonts.getFont(key),
                      button: GoogleFonts.getFont(key),
                      overline: GoogleFonts.getFont(key),
                    ),
                  ),
                  darkThemeData: (ThemeOptions.of(context).darkThemeData ??
                      ThemeData().copyWith(
                        textTheme: TextTheme(
                          headline1: GoogleFonts.getFont(key),
                          headline2: GoogleFonts.getFont(key),
                          headline3: GoogleFonts.getFont(key),
                          headline4: GoogleFonts.getFont(key),
                          headline5: GoogleFonts.getFont(key),
                          headline6: GoogleFonts.getFont(key),
                          subtitle1: GoogleFonts.getFont(key),
                          subtitle2: GoogleFonts.getFont(key),
                          bodyText1: GoogleFonts.getFont(key),
                          bodyText2: GoogleFonts.getFont(key),
                          caption: GoogleFonts.getFont(key),
                          button: GoogleFonts.getFont(key),
                          overline: GoogleFonts.getFont(key),
                        ),
                      )),
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
