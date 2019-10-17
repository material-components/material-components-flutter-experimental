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

import 'header_form.dart';

class FlyForm extends StatefulWidget {
  @override
  _FlyFormState createState() => _FlyFormState();
}

class _FlyFormState extends State<FlyForm> {
  final travelerController = TextEditingController();
  final countryDestinationController = TextEditingController();
  final destinationController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return HeaderForm(
      fields: <HeaderFormField>[
        HeaderFormField(
          iconData: Icons.person,
          title: 'Travelers',
          textController: travelerController,
        ),
        HeaderFormField(
          iconData: Icons.place,
          title: 'Select Origin',
          textController: countryDestinationController,
        ),
        HeaderFormField(
          iconData: Icons.airplanemode_active,
          title: 'Choose Destination',
          textController: destinationController,
        ),
        HeaderFormField(
          iconData: Icons.date_range,
          title: 'Select Dates',
          textController: dateController,
        ),
      ],
    );
  }
}
