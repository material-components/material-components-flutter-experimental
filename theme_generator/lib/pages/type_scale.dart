import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypeScale extends StatelessWidget {
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: FontScale(),
        ),
        Expanded(
          child: FontChooser(),
        ),
      ],
    );
  }
}

class FontScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Headline 1',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline1)),
        Text('Headline 2',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline2)),
        Text('Headline 3',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline3)),
        Text('Headline 4',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline4)),
        Text('Headline 5',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline5)),
        Text('Headline 6',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.headline6)),
        Text('Subtitle 1',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.subtitle1)),
        Text('Subtitle 2',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.subtitle2)),
        Text('Body 1',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.bodyText1)),
        Text('Body 2',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.bodyText2)),
        Text('BUTTON',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.button)),
        Text('Caption',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.caption)),
        Text('OVERLINE',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.overline)),
      ],
    );
  }
}

class FontChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Headline & Subtitles '),
        FontDropDown(),
        Text('Body & Captions '),
        FontDropDown(),
      ],
    );
  }
}

class FontDropDown extends StatefulWidget {
  @override
  _FontDropDownState createState() => _FontDropDownState();
}

class _FontDropDownState extends State<FontDropDown> {
  List<String> fonts = List<String>();
  TextEditingController controller = TextEditingController();
  String filter;

  final LayerLink layerLink = LayerLink();
  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    fonts = GoogleFonts.asMap().keys.toList();
//    controller.text = 'lato';
//    showFontsList();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
        print(filter);
//        if (filter == null || filter == '') {
//          hideFontsList();
//        }
//        else {
//          updateFontsList();
//        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void showFontsList(DragStartDetails details) {
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return _fontListView();
    });
    Overlay.of(context).insert(overlayEntry);
  }

  void updateFontsList(DragUpdateDetails details) =>
      overlayEntry.markNeedsBuild();

  void hideFontsList(DragEndDetails details) => overlayEntry.remove();

  Widget build(BuildContext context) {
    showFontsList;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CompositedTransformTarget(
            link: layerLink,
            child: GestureDetector(
              onPanStart: showFontsList,
              onPanUpdate: updateFontsList,
              onPanEnd: hideFontsList,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
//                suffixIcon: IconButton(icon: Icon(Icons.expand_more), onPressed: () => controller.clear(),),
                    hintText: 'Search...',
                  ),
                  controller: controller,
                ),
              ),
            ),
          ),
//          _fontListView(),
//          Expanded(
//            child: _fontListView(),
//          ),
        ],
      ),
    );
  }

  Widget _fontListView() {
    return Expanded(
      child: CompositedTransformFollower(
        link: layerLink,
        child: ListView.builder(
          itemCount: fonts.length,
          itemBuilder: (BuildContext context, int index) {
            if (filter == null || filter == '') {
              return _fontsRow(fonts[index]);
            } else if (fonts[index].contains(filter.toLowerCase())) {
              return _fontsRow(fonts[index]);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _fontsRow(String font) {
    return ListTile(
      title: Text(font),
    );
  }
}
