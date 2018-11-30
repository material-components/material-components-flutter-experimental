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

import 'flight.dart';

// This is where destination info should go
List<Flight> getFlights(Category category) {
  var allFlights = <Flight>[
    Flight(
      category: Category.findTrips,
      id: 0,
      isFeatured: true,
      destination: 'Aspen, Colorado',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 1,
      isFeatured: true,
      destination: 'Big Sur, California',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 2,
      isFeatured: false,
      destination: 'Khumbu Valley, Nepal',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 3,
      isFeatured: true,
      destination: 'Machu Picchu, Peru',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 4,
      isFeatured: false,
      destination: 'Maldives, South Asia',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 5,
      isFeatured: false,
      destination: 'Vitznau, Switzerland',
      layover: false,
    ),
    Flight(
      category: Category.findTrips,
      id: 6,
      isFeatured: false,
      destination: 'Madrid, Spain',
      layover: false,
    ),
  ];
  if (category == Category.findTrips) {
    return allFlights;
  } else {
    return allFlights.where((Flight p) => p.category == category).toList();
  }
}
