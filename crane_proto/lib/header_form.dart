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

import 'colors.dart';

class HeaderFormField {
  final IconData iconData;
  final String title;
  final TextEditingController textController;

  const HeaderFormField({this.iconData, this.title, this.textController});
}

class HeaderForm extends StatelessWidget {
  final List<HeaderFormField> fields;

  const HeaderForm({Key key, this.fields}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: kCranePurple800,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: fields.map((field) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: field.textController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    field.iconData,
                    size: 24,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  fillColor: kCranePurple700,
                  filled: true,
                  labelText: field.title,
                  hasFloatingPlaceholder: false,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
