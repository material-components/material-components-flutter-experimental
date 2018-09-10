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

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaintlessRoundedBorder extends InputBorder {
  const PaintlessRoundedBorder({
    borderSide: BorderSide.none,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  }) : assert(borderRadius != null),
        super(borderSide: borderSide);

  final BorderRadius borderRadius;

  @override
  PaintlessRoundedBorder copyWith({ BorderSide borderSide, BorderRadius borderRadius }) {
    return new PaintlessRoundedBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  bool get isOutline => false;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  PaintlessRoundedBorder scale(double t) {
    return new PaintlessRoundedBorder(borderSide: borderSide.scale(t));
  }

    @override
    Path getInnerPath(Rect rect, { TextDirection textDirection }) {
      return new Path()
        ..addRect(new Rect.fromLTWH(rect.left, rect.top, rect.width, math.max(0.0, rect.height - borderSide.width)));
    }

    @override
    Path getOuterPath(Rect rect, { TextDirection textDirection }) {
      return new Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
    }

    @override
    void paint(Canvas canvas, Rect rect, {
      double gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection textDirection,
    }) {
      // Do not paint
    }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other))
      return true;
    if (runtimeType != other.runtimeType)
      return false;
    final InputBorder typedOther = other;
    return typedOther.borderSide == borderSide;
  }

  @override
  int get hashCode => borderSide.hashCode;

  }
