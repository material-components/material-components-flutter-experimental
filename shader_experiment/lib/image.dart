// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class ImageDemo extends StatefulWidget {
  _ImageDemoState createState() => _ImageDemoState();
}

class _ImageDemoState extends State<ImageDemo>
    with SingleTickerProviderStateMixin {
  ui.Image _image;

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
                width: 300,
                height: 300,
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
    // This paints an image. Painting with an ImageShader should be like painting with a FragmentShader.
//    canvas.drawImage(image, Offset.zero, Paint()..shader = ImageShader(image, TileMode.repeated, TileMode.repeated, Matrix4.identity().storage));

    // This passes a broken SKSL program to see if the SKSL is being tested by Skia.
//    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..shader = FragmentShader('void main() {}'));

    FragmentShader fragmentShader = FragmentShader('''
        in shader input;
        
        void main(float2 fragCoord, inout half4 fragColor) {
          half4 s = sample(input);
          fragColor = half4(s.r, 0, s.b, 1.0);
        }
      ''');
    fragmentShader.setImage(image, TileMode.repeated, TileMode.repeated, Matrix4.identity().storage);
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = fragmentShader,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
