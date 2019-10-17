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

import 'package:flutter/foundation.dart';

// The following do not need to be enums, can just be strings that route
// to respective screens.
enum Category { findTrips, myTrips, savedTrips, priceAlerts, myAccount }

class Flight {
  const Flight({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.destination,
    @required this.layover,
  })  : assert(category != null),
        assert(id != null),
        assert(isFeatured != null),
        assert(destination != null),
        assert(layover != null);

  final Category category;
  final int id;
  final bool isFeatured;
  final String destination;
  final bool layover;
// TODO(plg): change to crane images
  String get assetName => 'assets/flights/$id.png';

  @override
  String toString() => '$destination (id=$id)';
}
