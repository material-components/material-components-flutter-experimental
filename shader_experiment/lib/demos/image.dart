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

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../api.dart';

class UploadImageAnimationDemo extends StatefulWidget {
  @override
  _UploadImageAnimationDemoState createState() => _UploadImageAnimationDemoState();
}

class _UploadImageAnimationDemoState extends State<UploadImageAnimationDemo> {
  ui.Image _image;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_image == null) {
      _image = await loadUiImage('images/water_300x300.png');
      setState(() {
        // Rebuild with image.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              SizedBox(
                width: 300,
                height: 300,
                child: TickingFragmentShader(
                  sksl: '''
                    in shader input;
                    uniform float t;
        
                    void main(float2 xy, inout half4 color) {
                      float frequency = 20.0;
                      float2 uv = xy / float2(300.0, 300.0);
                      float tt = (pow(sin(3.1415926 * t + pow(uv.y, 0.5)), 8.0) + 1.5) / 1.5;
                      uv *= float2x2(0.707, -0.707, 0.707, 0.707);
                      float2 nearest = 2.0 * fract(frequency * uv) - 1.0;
                      float dist = length(nearest);
                      half4 s = sample(input);
                      half brightness = (s.x * 0.2126 + s.y * 0.7152 + s.z * 0.0722) * s.w;
                      float radius = 1.0 - brightness;
                      radius *= tt;
                      float afwidth = 0.7 * length(float2(dFdx(dist), dFdy(dist)));
                      float aastep = smoothstep(radius - afwidth, radius + afwidth, dist);
                      float3 rbg = float3(0.8352, 0.7764, 0.9843);
                      float3 white = float3(1.0, 1.0, 1.0);
                      float3 fragcolor = mix(rbg, white, aastep);
                      color = half4(fragcolor, 1.0);
                    }
                  ''',
                  image: _image,
                ),
              )
          ],
        ),
      ),
    );
  }
}

class UploadImageAnimationDemo2 extends StatefulWidget {
  @override
  _UploadImageAnimationDemoState2 createState() => _UploadImageAnimationDemoState2();
}

class _UploadImageAnimationDemoState2 extends State<UploadImageAnimationDemo2> {
  ui.Image _image;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_image == null) {
      _image = await loadUiImage('images/water_300x300.png');
      setState(() {
        // Rebuild with image.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              SizedBox(
                width: 300,
                height: 300,
                child: TickingFragmentShader(
                  sksl: '''
                    in shader input;
                    uniform float t;
        
                    void main(float2 xy, inout half4 color) {
                      float2 uv = xy / float2(300.0, 300.0);
                      float tt = (sin(3.1415926 * t) + 2.0) / 2.0;
                      uv *= float2x2(0.707, -0.707, 0.707, 0.707);
                      float frequency = 20.0;
                      float2 nearest = 2.0 * fract(frequency * uv) - 1.0;
                      float dist = length(nearest);
                      half4 s = sample(input);
                      half brightness = (s.x * 0.2126 + s.y * 0.7152 + s.z * 0.0722) * s.w;
                      float radius = 1.0 - pow(brightness, 1.3);
                      radius *= tt;
                      float afwidth = 0.7 * length(float2(dFdx(dist), dFdy(dist)));
                      float aastep = smoothstep(radius - afwidth, radius + afwidth, dist);
                      float3 rbg = float3(0.8352, 0.7764, 0.9843);
                      float3 white = float3(1.0, 1.0, 1.0);
                      float3 fragcolor = mix(rbg, white, aastep);
                      color = half4(fragcolor, 1.0);
                    }
                  ''',
                  image: _image,
                ),
              )
          ],
        ),
      ),
    );
  }
}
// half4 s = sample(input);
//half brightness = (s.x * 0.2126 + s.y * 0.7152 + s.z * 0.0722) * s.w;
//float val = step(radius, dist);
//color = val * half4(s.r * half(sin(t / 1000.0)), 0, s.b, 1.0);


class ImageDemo extends StatefulWidget {
  _ImageDemoState createState() => _ImageDemoState();
}

class _ImageDemoState extends State<ImageDemo> {
  ui.Image _image;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_image == null) {
      _image = await loadUiImage('images/water.png');
      setState(() {
        // Rebuild with image.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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

    ui.FragmentShader fragmentShader = ui.FragmentShader('''
        in shader input;
        
        void main(float2 fragCoord, inout half4 fragColor) {
          half4 s = sample(input);
          fragColor = half4(s.r, 0, s.b, 1.0);
        }
      ''');
    fragmentShader.setImage(
      image,
      TileMode.repeated,
      TileMode.repeated,
      Matrix4.identity().storage,
    );
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = fragmentShader,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CardWarpDemo extends StatefulWidget {
  @override
  _CardWarpDemoState createState() => _CardWarpDemoState();
}

class _CardWarpDemoState extends State<CardWarpDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fragment Shaders')),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller.view,
          builder: (context, child) {
            return ImageFiltered(
              imageFilter: ui.ImageFilter.blur(
                sigmaX: _controller.value * 5,
                sigmaY: _controller.value * 5,
              ),
              child: SizedBox(
                height: 300,
                width: 300,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.headset),
                      Text('Headset'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.animation),
        onPressed: () {
          if (_controller.velocity <= 0) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
      ),
    );
  }
}
