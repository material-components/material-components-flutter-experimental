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
import 'package:meta/meta.dart';

import 'colors.dart';
import 'model/product.dart';
import 'app.dart';

class MenuPage extends StatelessWidget {

  const MenuPage({
    Key key,
  });

  Widget _buildMenu(BuildContext context) {
    // TODO(tianlun): format strings e.g. 'findTrips' to 'Find Trips'
    final ThemeData theme = Theme.of(context);
    return Column(
      children: <Widget>[
        SizedBox(height: 16.0),
        Text('???',
          style: theme.textTheme.body2,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14.0),
        Container(
          width: 70.0,
          height: 2.0,
          color: kCranePurple800,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO(tianlun): Use tabs to determine which text fields to show
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        color: kCranePurple800,
        child: ListView(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                semanticLabel: 'back',
              ),
              onPressed: (){
                Navigator.pop(context);
              }
            ),
            Text('Find Trips'),
            Text('My Trips'),
            Text('Saved Trips'),
            Text('Price Alerts'),
            Text('My Account'),
          ],
        ),
      ),
    );
  }
}
