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

import 'model/data.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {

  const HomePage();

  ListView _buildGridCards(BuildContext context) {
//    Column products = getProducts(Category.findTrips);
//
//    if (products == null || products.isEmpty) {
//      return Column();
//    }

  final ThemeData theme = Theme.of(context);

  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.all(20.0),
    children: <Widget>[
      const Text('I\'m dedicating every day to you'),
      const Text('Domestic life was never quite my style'),
      const Text('When you smile, you knock me out, I fall apart'),
      const Text('And I thought I was so smart'),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildGridCards(context),
      ),
    );
  }
}

//class View extends StatelessWidget {
//  final List<Product> products;
//
//  View({Key key, this.products});
//
//  List<Container> _buildColumns(BuildContext context) {
//    if (products == null || products.isEmpty) {
//      return <Container>[];
//    }
//
//    return
//  }
//}