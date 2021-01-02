import 'package:tinycolor/tinycolor.dart';

import 'package:flutter/material.dart';
import 'package:theme_generator/constants.dart';
import 'package:theme_generator/data/theme_options.dart';

class CurrentScheme extends StatefulWidget {
  @override
  _CurrentSchemeState createState() => _CurrentSchemeState();
}

class _CurrentSchemeState extends State<CurrentScheme> {
//  ComputeLuminance()
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: SchemeTemplate(
            selectedScheme: SelectedScheme.PrimaryColor,
            child: ColorScheme(
              color: ThemeOptions.of(context).primaryColor,
              selectedScheme: SelectedScheme.PrimaryColor,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: SchemeTemplate(
            selectedScheme: SelectedScheme.SecondaryColor,
            child: ColorScheme(
              color: ThemeOptions.of(context).secondaryColor,
              selectedScheme: SelectedScheme.SecondaryColor,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SchemeTemplate(
                  selectedScheme: SelectedScheme.PrimaryText,
                  child: TextScheme(
                    color: ThemeOptions.of(context).primaryColor,
                    textColor: ThemeOptions.of(context).primaryTextColor,
                    selectedScheme: SelectedScheme.PrimaryText,
                  ),
                ),
              ),
              Expanded(
                child: SchemeTemplate(
                  selectedScheme: SelectedScheme.SecondaryText,
                  child: TextScheme(
                    color: ThemeOptions.of(context).secondaryColor,
                    textColor: ThemeOptions.of(context).secondaryTextColor,
                    selectedScheme: SelectedScheme.SecondaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SchemeTemplate extends StatefulWidget {
  const SchemeTemplate({
    this.selectedScheme,
    this.child,
  });

  final SelectedScheme selectedScheme;
  final Widget child;

  @override
  _SchemeTemplateState createState() => _SchemeTemplateState();
}

class _SchemeTemplateState extends State<SchemeTemplate> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: () {
          setState(
            () {
              ThemeOptions.update(
                context,
                ThemeOptions.of(context)
                    .copyWith(selectedScheme: widget.selectedScheme),
              );
              print(ThemeOptions.of(context).selectedScheme);
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ThemeOptions.of(context).selectedScheme ==
                        widget.selectedScheme
                    ? Colors.grey[700]
                    : Colors.transparent,
                blurRadius: 100,
              ),
            ],
          ),
          child: Padding(padding: EdgeInsets.all(22), child: widget.child),
        ),
      ),
    );
  }
}

class ColorScheme extends StatefulWidget {
  const ColorScheme({this.color, this.selectedScheme});

  final Color color;
  final SelectedScheme selectedScheme;

  @override
  _ColorSchemeState createState() => _ColorSchemeState();
}

class _ColorSchemeState extends State<ColorScheme> {
  @override
  Widget build(BuildContext context) {
    Color textColor = (widget.color ?? Colors.white).computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;

    Color lightColor = (widget.color != null)
        ? TinyColor(widget.color).brighten(20).color
        : Colors.white;
    Color darkColor = (widget.color != null)
        ? TinyColor(widget.color ?? Colors.white).darken(20).color
        : Colors.white;
    Color lightTextColor =
        lightColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    Color darkTextColor =
        darkColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(widget.selectedScheme.displayTitle()),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                color: widget.color ?? Colors.white,
                border: Border.all(color: Colors.black)),
            child: Stack(
              children: <Widget>[
                Text(
                  widget.color != null
                      ? '#${widget.color.value.toRadixString(16)}'
                      : '',
                  style: TextStyle(color: textColor ?? Colors.black),
                  textAlign: TextAlign.start,
                ),
                Center(
                  child: CircleAvatar(
                    foregroundColor: widget.color ?? Colors.white,
                    backgroundColor: textColor,
                    child: Text(
                      'P',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (widget.color != null &&
                    widget.selectedScheme ==
                        ThemeOptions.of(context).selectedScheme)
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: FlatButton(
                      onPressed: () {
                        setState(
                          () => ThemeOptions.update(
                            context,
                            ThemeOptions.of(context)
                                .setSelectedSchemeColorToNull(),
                          ),
                        );
                      },
                      child: Text(
                        'RESET',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: lightColor,
                      border: Border.all(color: Colors.black)),
                  child: RichText(
                    text: TextSpan(
                      text: widget.selectedScheme.displayLightColorText(),
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(color: lightTextColor),
                      children: [
                        if (widget.color != null)
                          TextSpan(
                            text: '#${lightColor.value.toRadixString(16)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightTextColor),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: darkColor,
                      border: Border.all(color: Colors.black)),
                  child: RichText(
                    text: TextSpan(
                      text: widget.selectedScheme.displayDarkColorText(),
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(color: darkTextColor),
                      children: [
                        if (widget.color != null)
                          TextSpan(
                            text: '#${darkColor.value.toRadixString(16)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkTextColor),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TextScheme extends StatefulWidget {
  const TextScheme({this.color, this.textColor, this.selectedScheme});

  final Color color;
  final Color textColor;
  final SelectedScheme selectedScheme;

  @override
  _TextSchemeState createState() => _TextSchemeState();
}

class _TextSchemeState extends State<TextScheme> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            widget.selectedScheme.displayTitle(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        Expanded(
          child: Container(
            color: widget.color ?? Theme.of(context).colorScheme.secondary,
            child: Stack(
              children: [
                Text(
                  (widget.textColor != null)
                      ? '#${widget.textColor.value.toRadixString(16)}'
                      : '',
                  style: TextStyle(color: widget.textColor),
                ),
                Center(
                  child: CircleAvatar(
                    foregroundColor: widget.color ?? Colors.black,
                    backgroundColor: widget.textColor ?? Colors.white,
                    child: Text(
                      'P',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (widget.textColor != null &&
                    widget.selectedScheme ==
                        ThemeOptions.of(context).selectedScheme)
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: FlatButton(
                      onPressed: () {
                        setState(
                          () => ThemeOptions.update(
                            context,
                            ThemeOptions.of(context)
                                .setSelectedSchemeColorToNull(),
                          ),
                        );
                      },
                      child: Text(
                        'RESET',
                        style: TextStyle(
                          color: (widget.color ?? Colors.white)
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
