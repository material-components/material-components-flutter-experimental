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
import 'colors.dart';

class BottomNavItem extends StatelessWidget {
  BottomNavItem({
    this.isSelected = false,
    this.icon,
    this.title = '',
    @required this.onTap,
  });

  final bool isSelected;
  final IconData icon;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: isSelected ? blue500 : grey600),
          SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: isSelected ? blue500 : grey600),
          )
        ],
      ),
    );
  }
}
