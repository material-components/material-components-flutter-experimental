// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// Interaction models.
enum DeviceCorporealContext {
  /// Viewed only.
  ambient,

  /// Interactive.
  focused,

  /// Mixed: sometimes viewed only, sometimes interactive.
  multi,
}

/// Real world device purposes.
enum DeviceCorporealType {
  /// In-car console display.
  auto,

  /// Stationary / in-home tablet on a surface.
  countertop,

  /// Traditional desktop computer.
  desktop,

  /// Foldable phone.
  foldableHandheld,

  /// Slab-style phone.
  slabHandheld,

  /// Mobile tablet.
  tabletHandheld,

  /// Large screen. Usually not interactive with touch or mouse.
  tv,

  /// Wearable watch.
  wristwatch,
}

/// Information about a piece of media relating to variable distance.
class ExperimentalMediaQuery extends MediaQueryData {
  /// Creates additional data for a [MediaQuery] with explicit values.
  const ExperimentalMediaQuery({
    this.deviceCorporealContext = DeviceCorporealContext.focused,
    this.deviceCorporealType = DeviceCorporealType.slabHandheld,
    this.isFolded,
    this.viewerCount = 1,
    this.viewingAngle = 0,
    this.viewingProximity = 36,
  })  : assert(deviceCorporealContext != null),
        assert(deviceCorporealType != null),
        assert(viewingAngle != null);

  /// Type of interaction model of the screen.
  ///
  /// Default is [DeviceCorporealContext.focused].
  final DeviceCorporealContext deviceCorporealContext;

  /// Intended purpose of the screen in the real world.
  ///
  /// Default is [DeviceCorporealType.slabHandheld].
  final DeviceCorporealType deviceCorporealType;

  /// Number of users facing the screen.
  /// Null means 'unknown'.
  ///
  /// Default is null.
  final int viewerCount;

  /// If the phone is foldable, is it folded (true) or not (false).
  /// If the phone is not foldable, null.
  ///
  /// Default is null.
  final bool isFolded;

  /// Angle of eyes of the main user to the screen.
  /// 0 means 'unknown'.
  ///
  /// Default is 0.
  final double viewingAngle;

  /// How near the main user is to the screen in centimeters (cm).
  ///
  /// Default is 36.
  final double viewingProximity;
}
