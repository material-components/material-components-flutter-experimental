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
import 'package:flutter/widgets.dart';

class BorderTabIndicator extends Decoration {
  BorderTabIndicator(this.indicatorHeight) : super();

  final double indicatorHeight;

  @override
  _BorderPainter createBoxPainter([VoidCallback onChanged]) {
    return new _BorderPainter(this, indicatorHeight, onChanged);
  }
}

class _BorderPainter extends BoxPainter {
  _BorderPainter(this.decoration, this.indicatorHeight, VoidCallback onChanged)
      : assert(decoration != null),
        assert(indicatorHeight >= 0),
        super(onChanged);

  final BorderTabIndicator decoration;
  final double indicatorHeight;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final double horizontalInset = 12;
    final Rect rect = Offset(offset.dx + horizontalInset,
            (configuration.size.height / 2) - indicatorHeight / 2) &
        Size(configuration.size.width - 2 * horizontalInset, indicatorHeight);
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(56.0)),
      paint,
    );
  }
}
