import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:shaderexperiment/static.dart';

import 'animated.dart';

class ImageDemo extends StatefulWidget {
  _ImageDemoState createState() => _ImageDemoState();
}

class _ImageDemoState extends State<ImageDemo>
    with SingleTickerProviderStateMixin {
  ui.Image _image;
  AnimationController _animationController;

  Future<ui.Image> _loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_image == null) {
      _image = await _loadUiImage('images/water.png');
      setState(() {
        // Rebuild with image.
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fragment Shaders')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Fragment Shader',
            ),
            if (_image != null)
              SizedBox(
                width: 200,
                height: 200,
                child: CustomPaint(
                  painter: _ImagePainter(
                    image: _image,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

// In this class, the FragmentShader can be tested.
class _ImagePainter extends CustomPainter {
  _ImagePainter({this.image});

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: Pass image as in input to the shader program.

    // This paints an image. Painting with an ImageShader should be like painting with a FragmentShader.
//    canvas.drawImage(image, Offset.zero, Paint()..shader = ImageShader(image, TileMode.clamp, TileMode.clamp, Matrix4.identity().storage));

    // This paints a red box without a shader, just to make sure the custom painter works.
//    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.red);

    // This passes a broken SKSL program to see if the SKSL is being tested by Skia.
//    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..shader = FragmentShader('void main() {}'));

    // This should produce a simple SKSL program where every pixel is the same color.
//    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..shader = FragmentShader('void main(float2 fragCoord, inout half4 fragColor) {fragColor = half4(1.0, 0, 1.0, 1.0);}'));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
