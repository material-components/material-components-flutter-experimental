import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AnypixelBridge extends StatefulWidget {
  AnypixelBridge({this.child, this.onPressed});

  final Widget child;
  final ValueChanged<Offset> onPressed;

  @override
  State<StatefulWidget> createState() => AnypixelBridgeState();
}

class AnypixelBridgeState extends State<AnypixelBridge>
    with SingleTickerProviderStateMixin {
  GlobalKey globalKey = GlobalKey();
  Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = this.createTicker((Duration duration) {
      setState(() {});
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _captureImage(),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        return Center(
          child: Container(
            width: 140,
            height: 42,
            child: RepaintBoundary(
              child: widget.child,
              key: globalKey,
            ),
          ),
        );
      },
    );
  }

  Future<ui.Image> _captureImage() async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 1);

    ByteData byteData =
    await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    Uint8List imageBytes = byteData.buffer.asUint8List();

    // TODO(clocksmith): better rgba => rgb
    List<int> noAlphaBytes = [0];
    for (int i = 0; i < imageBytes.length; i++) {
      if ((i + 1) % 4 != 0) {
        noAlphaBytes.add(imageBytes[i]);
      }
    }

//    List<int> noAlphaBytes = [0];
//    for (int i = 0; i < imageBytes.length; i += 4) {
//      int r = imageBytes[i];
//      int g = imageBytes[i + 1];
//      int b = imageBytes[i + 2];
//      int a = imageBytes[i + 3];
//      noAlphaBytes
//        ..add((r * a / 255).round())
//        ..add((g * a / 255).round())
//        ..add((b * a / 255).round());
//    }

    var body = new Map<String, dynamic>();
    body['arr'] = noAlphaBytes.toString();

    // 10.0.2.2 for android ?
    final String local = '10.0.2.2';
//    final String local = '127.0.0.1';
    http.post('http://$local:8000/flutter/publish-view', body: body);
    http.get('http://$local:8000/flutter/read-tap').then((Response val) {
      List<dynamic> arr = jsonDecode(val.body);
      if (arr.length == 4 && arr[3] == 1) {
        widget.onPressed(Offset(arr[2].toDouble(), arr[1].toDouble()));
      }
    });

    return image;
  }
}