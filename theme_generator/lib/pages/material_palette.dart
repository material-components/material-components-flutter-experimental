import 'package:flutter/material.dart';
import 'package:theme_generator/constants.dart';
import 'package:theme_generator/data/theme_options.dart';

class MaterialPalette extends StatelessWidget {
  static final whiteAccent = MaterialAccentColor(
    0xFFFFFFFF,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
    },
  );
  final List<List<Color>> _colorTypes = [
    [Colors.red, Colors.redAccent],
    [Colors.pink, Colors.pinkAccent],
    [Colors.purple, Colors.purpleAccent],
    [Colors.deepPurple, Colors.deepPurpleAccent],
    [Colors.indigo, Colors.indigoAccent],
    [Colors.blue, Colors.blueAccent],
    [Colors.lightBlue, Colors.lightBlueAccent],
    [Colors.cyan, Colors.cyanAccent],
    [Colors.teal, Colors.tealAccent],
    [Colors.green, Colors.greenAccent],
    [Colors.lightGreen, Colors.lightGreenAccent],
    [Colors.lime, Colors.limeAccent],
    [Colors.yellow, Colors.yellowAccent],
    [Colors.amber, Colors.amberAccent],
    [Colors.orange, Colors.orangeAccent],
    [Colors.deepOrange, Colors.deepOrangeAccent],
    [Colors.brown, whiteAccent],
    [Colors.grey, whiteAccent],
    [Colors.blueGrey, whiteAccent],
  ];

  final List<String> _colorNames = [
    'Red',
    'Pink',
    'Purple',
    'Deep Purple',
    'Indigo',
    'Blue',
    'Light Blue',
    'Cyan',
    'Teal',
    'Green',
    'Light Green',
    'Lime',
    'Yellow',
    'Amber',
    'Orange',
    'DeepOrange',
    'Brown',
    'Grey',
    'BlueGrey',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 15,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        ...colorPaletteHeader(),
        for (int counter = 0; counter < _colorTypes.length; counter++)
          ...colorRow(
            _colorTypes[counter][0],
            _colorTypes[counter][1],
            _colorNames[counter],
          ),
      ],
    );
  }

  List<Widget> colorPaletteHeader() {
    return [
      Container(),
      Align(
        alignment: Alignment.center,
        child: Text('50', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('100', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('200', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('300', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('400', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('500', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('600', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('700', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('800', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('900', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('100', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('200', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('400', textAlign: TextAlign.center),
      ),
      Align(
        alignment: Alignment.center,
        child: Text('700', textAlign: TextAlign.center),
      ),
    ];
  }

  List<Widget> colorRow(
      MaterialColor color, MaterialAccentColor colorAccent, String colorName) {
    return [
      Align(
        alignment: Alignment.center,
        child: Text(colorName),
      ),
      ColorBox(color: color.shade50),
      ColorBox(color: color.shade100),
      ColorBox(color: color.shade200),
      ColorBox(color: color.shade300),
      ColorBox(color: color.shade400),
      ColorBox(color: color.shade500),
      ColorBox(color: color.shade600),
      ColorBox(color: color.shade700),
      ColorBox(color: color.shade800),
      ColorBox(color: color.shade900),
      ColorBox(color: colorAccent.shade100),
      ColorBox(color: colorAccent.shade200),
      ColorBox(color: colorAccent.shade400),
      ColorBox(color: colorAccent.shade700),
    ];
  }
}

class ColorBox extends StatefulWidget {
  const ColorBox({
    this.color,
  });

  final Color color;

  @override
  _ColorBoxState createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  bool _hovering = false;
  bool isActive;

  bool selectedSchemeHasActiveColor(BuildContext context) {
    switch (ThemeOptions.of(context).selectedScheme) {
      case SelectedScheme.PrimaryColor:
        return widget.color == ThemeOptions.of(context).primaryColor;
        break;
      case SelectedScheme.SecondaryColor:
        return widget.color == ThemeOptions.of(context).secondaryColor;
        break;
      case SelectedScheme.PrimaryText:
        return widget.color == ThemeOptions.of(context).primaryTextColor;
        break;
      case SelectedScheme.SecondaryText:
        return widget.color == ThemeOptions.of(context).secondaryTextColor;
        break;
      default:
        return false;
    }
  }

  Widget build(BuildContext context) {
    isActive = selectedSchemeHasActiveColor(context);
    return GestureDetector(
      onTap: () {
//        print(ThemeOptions.of(context).primaryColor);
//        print(ThemeOptions.of(context).lightThemeData.colorScheme.primary);
        setState(
          () {
            switch (ThemeOptions.of(context).selectedScheme) {
              case SelectedScheme.PrimaryColor:
                ThemeOptions.update(
                  context,
                  !isActive
                      ? ThemeOptions.of(context).updatePrimaryColors(
                          widget.color,
                          isActive,
                        )
                      : ThemeOptions.of(context).setSelectedSchemeColorToNull(),
                );
                break;
              case SelectedScheme.SecondaryColor:
                ThemeOptions.update(
                  context,
                  !isActive
                      ? ThemeOptions.of(context).updateSecondaryColors(
                          widget.color,
                          isActive,
                        )
                      : ThemeOptions.of(context).setSelectedSchemeColorToNull(),
                );
                break;
              case SelectedScheme.PrimaryText:
                ThemeOptions.update(
                  context,
                  !isActive
                      ? ThemeOptions.of(context).copyWith(
                          primaryTextColor: widget.color,
                        )
                      : ThemeOptions.of(context).setSelectedSchemeColorToNull(),
                );
                break;
              case SelectedScheme.SecondaryText:
                ThemeOptions.update(
                  context,
                  !isActive
                      ? ThemeOptions.of(context).copyWith(
                          secondaryTextColor: !isActive ? widget.color : null,
                        )
                      : ThemeOptions.of(context).setSelectedSchemeColorToNull(),
                );
                break;
            }
          },
        );
      },
      child: MouseRegion(
        onEnter: (e) => _mouseEnter(true),
        onExit: (e) => _mouseEnter(false),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: isActive ? BoxShape.circle : BoxShape.rectangle,
            color: widget.color,
            borderRadius: isActive
                ? null
                : _hovering ? BorderRadius.circular(30) : BorderRadius.zero,
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
          ),
        ),
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
