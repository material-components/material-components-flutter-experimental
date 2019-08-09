import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SearchDemo extends StatefulWidget {
  static const String routeName = '/material/search';

  @override
  _SearchDemoState createState() => new _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  final _SearchDemoSearchDelegate _delegate = _SearchDemoSearchDelegate();

  int _lastIntegerSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            tooltip: 'Navigation menu',
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              color: Colors.white,
              progress: _delegate.transitionAnimation,
            ),
            onPressed: () {}),
        title: const Text('Animals'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String selected = await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
//              if (selected != null && selected != _lastIntegerSelected) {
//                setState(() {
////                  _lastIntegerSelected = selected;
//                });
//              }
            },
          ),
          IconButton(
            tooltip: 'More',
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MergeSemantics(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      const Text('Press the '),
                      const Tooltip(
                        message: 'search',
                        child: const Icon(
                          Icons.search,
                          size: 18.0,
                        ),
                      ),
                      const Text(' icon in the AppBar'),
                    ],
                  ),
                  const Text('and search for an animal!'),
                ],
              ),
            ),
            const SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }
}

class _SearchDemoSearchDelegate extends SearchDelegate<String> {
//  final List<int> _data = new List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<String> _data = [
    'cat',
    'camel',
    'bird',
    'bison',
    'butterfly',
    'bug'
  ];
  final List<String> _history = ['horse', 'cat', 'whale', 'butterfly', 'zebra'];

  List<String> imageNames = [
    'bird1',
    'bird2',
    'bird3',
    'bird4',
    'bird5',
    'bird6',
    'bird7',
    'bird8',
    'cat1',
    'cat2',
    'cat3',
//      'cat4',
    'cat5',
    'cat6',
    'cat7',
    'dog1',
    'dog2',
    'dog3',
//      'dog4',
    'dog5',
    'dog6',
    'dog7',
  ];

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _data.where((String s) => s.startsWith(query));

    return _SuggestionList(
      query: query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Image> images = imageNames
        .where((String imageName) => imageName.startsWith(query))
        .map((String imageName) => Image.asset(
              'assets/$imageName.jpg',
              fit: BoxFit.cover,
            ))
        .toList();

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: images,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : new IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.title, this.searchDelegate});

  final String title;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, title);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
