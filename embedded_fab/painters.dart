// Copyright 2018-present the Material Components for Flutter authors. All Rights Reserved.
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
import 'dart:math' as Math;

import 'colors.dart';
import 'notch.dart';
import 'shape_type.dart';

class ContainerPainter extends CustomPainter {
  ContainerPainter({
    @required this.shape,
    this.fillColor = Colors.white,
    this.strokeColor = Colors.black87,
    this.hasStroke = false,
    this.hasShadow = true,
  });

  final Color fillColor;
  final Color strokeColor;
  final bool hasStroke;
  final bool hasShadow;
  final ShapeType shape;

  static const _kBumpRadius = 60.0;
  static const _kFABRadius = 30.0;
  static const _kMiniFABRadius = 20.0;
  static const _kNotchPadding = 8.0;

  Path _fabPath;
  Path _silhouettePath;

  @override
  void paint(Canvas canvas, Size size) {
    switch (shape) {
      case ShapeType.Bump:
        {
          num degToRad(num deg) => deg * (Math.pi / 180);
          Rect rect = Rect.fromCenter(
            center: Offset(
              size.width * .5,
              46,
            ),
            height: _kBumpRadius,
            width: _kBumpRadius,
          );

          _silhouettePath = Path()
            ..moveTo(0, 36)
            ..lineTo(size.width * .5 - _kBumpRadius * .5 + 2, 24)
            ..addArc(
              rect,
              degToRad(200),
              degToRad(138),
            )
            ..lineTo(size.width, 36)
            ..lineTo(size.width, size.height)
            ..lineTo(0, size.height)
            ..lineTo(0, 36);

          _fabPath = Path()
            ..addArc(
              rect.shift(Offset(0, -11)),
              degToRad(0),
              degToRad(360),
            );
          break;
        }
      case ShapeType.Cut:
        {
          _silhouettePath = GoogleBabShape().getOuterPath(
              Offset(0, 36) & size,
              Rect.fromCenter(
                center: Offset(size.width * .5, 24),
                width: _kFABRadius * 2 + _kNotchPadding,
                height: _kFABRadius * 2 + _kNotchPadding,
              ));
          _fabPath = Path()
            ..addOval(Offset(size.width * .5 - _kFABRadius, 24 - _kFABRadius) &
                Size.fromRadius(_kFABRadius));
          break;
        }
      case ShapeType.Flat:
        {
          _silhouettePath = Path()..addRect(Offset(0, 36) & size);
          _fabPath = Path()
            ..addOval(Rect.fromCenter(
                center: Offset(size.width / 2, 62),
                width: _kMiniFABRadius * 2,
                height: _kMiniFABRadius * 2));
          break;
        }
    }

    Path silhouetteShadowPath = Path.from(_silhouettePath)
        .transform(Matrix4.translationValues(0, -5, 0).storage);

    canvas.drawShadow(silhouetteShadowPath, Colors.black87, 2, false);

    canvas.drawPath(_silhouettePath, Paint()..color = Colors.white);

    if (hasShadow) {
      Path shadowPath = Path.from(_fabPath)
          .transform(Matrix4.translationValues(0, -4, 0).storage);
      canvas.drawShadow(shadowPath, Colors.black87, 4, true);
    }

    canvas.drawPath(
        _fabPath,
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill);

    if (hasStroke) {
      canvas.drawPath(
          _fabPath,
          Paint()
            ..color = strokeColor
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    if (shape == ShapeType.Flat) return false;

    return _fabPath.getBounds().contains(position);
  }
}

class PlusPainter extends CustomPainter {
  PlusPainter({
    this.iconSize = 36,
    this.yOffset = 0,
    this.color,
  });

  final double iconSize;
  final double yOffset;
  final Color color;

  // These are based on the original branded icon asset. The asset size is
  // 36 x 36, the thickness of the plus is 4 and the padding is 6.
  double get _iconStrokeWidth => iconSize / 9;

  double get _iconPadding => iconSize / 6;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintIt(Color color) => Paint()
      ..color = this.color ?? color
      ..style = PaintingStyle.fill;

    final halfIconSize = iconSize / 2;
    final halfIconStrokeWidth = _iconStrokeWidth / 2;

    final offset = Offset(size.width * .5 - halfIconSize, yOffset - halfIconSize);
    canvas
      // Bottom rectangle.
      ..drawRect(
        Rect.fromLTWH(
          halfIconSize - halfIconStrokeWidth,
          halfIconSize,
          _iconStrokeWidth,
          halfIconSize - _iconPadding,
        ).shift(offset),
        paintIt(green500),
      )
      // Left rectangle.
      ..drawRect(
        Rect.fromLTWH(
          _iconPadding,
          halfIconSize - halfIconStrokeWidth,
          halfIconSize,
          _iconStrokeWidth,
        ).shift(offset),
        paintIt(googleYellow500),
      )
      // The right rectangle extends to the center of the plus so that it shows
      // up as a diagonal cut against the top.
      ..drawRect(
        Rect.fromLTWH(
          halfIconSize - halfIconStrokeWidth,
          halfIconSize - halfIconStrokeWidth,
          halfIconSize + halfIconStrokeWidth - _iconPadding,
          _iconStrokeWidth,
        ).shift(offset),
        paintIt(blue500),
      )
      // The top part of the plus is the only non rectangle, it has a diagonal
      // cut corner that sits on top of the right rectangle.
      ..drawPath(
        Path()
          ..addPolygon(
            [
              // Top left point.
              Offset(
                    halfIconSize - halfIconStrokeWidth,
                    _iconPadding,
                  ) +
                  offset,
              // Bottom left point.
              Offset(
                    halfIconSize - halfIconStrokeWidth,
                    halfIconSize + halfIconStrokeWidth,
                  ) +
                  offset,
              // Bottom right point.
              Offset(
                    halfIconSize + halfIconStrokeWidth,
                    halfIconSize - halfIconStrokeWidth,
                  ) +
                  offset,
              // Top right point.
              Offset(
                    halfIconSize + halfIconStrokeWidth,
                    _iconPadding,
                  ) +
                  offset,
            ],
            true,
          ),
        paintIt(red500),
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
