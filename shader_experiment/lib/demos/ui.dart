import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../api.dart';

class ImageSendDemo extends StatefulWidget {
  @override
  _ImageSendDemoState createState() => _ImageSendDemoState();
}

class _ImageSendDemoState extends State<ImageSendDemo> {
  final List<ImagePreview> _previews = [];

  final List<String> _images = [
    'images/water_300x300.png',
    'images/nyc_300x300.png',
    'images/pasta_300x300.png',
    'images/brin_300x300.png',
    'images/dog_300x300.png',
    'images/park_300x300.png',
//    'images/water_300x300.png',
//    'images/nyc_300x300.png',
//    'images/pasta_300x300.png',
//    'images/brin_300x300.png',
//    'images/dog_300x300.png',
//    'images/park_300x300.png',
  ];

  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    print(_previews.length);
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: _previews.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _previews[index],
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 220,
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  for (final imageAsset in _images)
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(imageAsset),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _previews.add(ImagePreview(imageAsset));
                            });
                            Timer(Duration(milliseconds: 100), () {
                              _controller.animateTo(
                                _controller.position.maxScrollExtent,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 250),
                              );
                            });
                          },
                        ),
                      ],
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ImagePreview extends StatefulWidget {
  final String assetName;

  ImagePreview(this.assetName);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool _isComplete = false;
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isComplete = true;
      });
    });
  }

  @override
  void didChangeDependencies() async {
    print('didChangeDependencies');
    super.didChangeDependencies();
    if (_image == null) {
      _image = await loadUiImage(widget.assetName);
      setState(() {
        // Rebuild with image.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          if (_image != null)
            SizedBox(
              width: 300,
              height: 300,
              child: TickingFragmentShader(
                sksl: sksl1,
                image: _image,
              ),
            ),
          AnimatedOpacity(
            opacity: _isComplete ? 1.0 : 0.0,
            child: Image.asset(widget.assetName),
            duration: Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}

const String sksl1 = '''
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
''';

const String sksl2 = '''
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
''';
