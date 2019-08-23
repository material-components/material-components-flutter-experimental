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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Widget> get navigationViews => [
      NavigationView(
        icon: Icon(Icons.inbox),
        title: 'Inbox',
        order: [0, 5, 1, 4, 3, 2, 6, 7],
        times: [
          '2:44pm',
          '2:55pm',
          '3:08pm',
          'Nov 2',
          'Nov 2',
          'Nov 4',
          'Nov 4',
          'Nov 6'
        ],
      ),
      NavigationView(
        icon: Icon(Icons.star),
        title: 'Starred',
        order: [5, 2, 0, 6, 1, 4, 3, 7],
        times: [
          '2:08pm',
          '2:08pm',
          '2:11pm',
          'Nov 3',
          'Nov 4',
          'Nov 5',
          'Nov 5',
          'Nov 6'
        ],
      ),
      NavigationView(
        icon: Icon(Icons.send),
        title: 'Sent',
        order: [1, 4, 6, 2, 5, 3, 7, 0],
        times: [
          '12:08pm',
          '1:07pm',
          '2:08pm',
          '3:08pm',
          '4:08pm',
          '6:01pm',
          '6:40pm',
          '7:20pm'
        ],
      ),
      NavigationView(
        icon: Icon(Icons.archive),
        title: 'Archived',
        order: [6, 7, 2, 0, 4, 1, 3, 5],
        times: [
          '2:08pm',
          '2:09pm',
          'Nov 2',
          'Nov 2',
          'Nov 3',
          'Nov 6',
          'Nov 6',
          'Nov 8'
        ],
      ),
    ];

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Widget> _navigationViews = [
    NavigationView(
      icon: Icon(Icons.inbox),
      title: 'Inbox',
      order: [0, 5, 1, 4, 3, 2],
      times: ['2:44pm', '2:55pm', '3:08pm', 'Nov 2', 'Nov 2', 'Nov 4'],
    ),
    NavigationView(
      icon: Icon(Icons.star),
      title: 'Starred',
      order: [5, 2, 0, 1, 4, 3],
      times: ['2:08pm', '2:08pm', '2:11pm', 'Nov 3', 'Nov 4', 'Nov 5'],
    ),
    NavigationView(
      icon: Icon(Icons.send),
      title: 'Sent',
      order: [1, 4, 2, 5, 3, 0],
      times: ['12:08pm', '1:07pm', '2:08pm', '3:08pm', '4:08pm', '6:01pm'],
    ),
    NavigationView(
      icon: Icon(Icons.archive),
      title: 'Archived',
      order: [2, 0, 4, 1, 3, 5],
      times: ['2:08pm', '2:09pm', 'Nov 2', 'Nov 2', 'Nov 3', 'Nov 6'],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: textTheme.title.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey.shade300,
              radius: 16,
              child: Text(
                'AZ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (NavigationView view in _navigationViews)
            BottomNavigationBarItem(
              icon: view.icon,
              title: Text(view.title),
            ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      body: Center(
        child: _navigationViews[_selectedIndex],
      ),
    );
  }
}

class NavigationView extends StatelessWidget {
  NavigationView({this.icon, this.title, this.order, this.times});

  final Icon icon;
  final String title;
  final List<int> order;
  final List<String> times;

  final List<_ListItemContent> _itemContents = [
    _ListItemContent(
      title: 'Google Material Review',
      name: 'Damien Correll',
      description: 'Hey guys, here are all of the notes from today',
      initials: 'DC',
      color: Colors.red,
      attachments: _ChipAttachments(),
    ),
    _ListItemContent(
      title: 'Stickersheet sync',
      name: 'Amy, David, Irin',
      description: 'What\'s the latest version of the stickersheet',
      initials: 'AR',
      color: Colors.blue,
    ),
    _ListItemContent(
      title: 'Architecture Article Photos',
      name: 'David, Andrea, Sehee',
      description: 'Hey all, as discussed here are the photos',
      initials: 'DA',
      color: Colors.purple,
    ),
    _ListItemContent(
      title: 'Sketch Article',
      name: 'Cortney Cassidy',
      description: 'Found this on Twitter',
      initials: 'CC',
      color: Colors.green,
    ),
    _ListItemContent(
      title: 'Stickersheet notes',
      name: 'Andrea Bravo',
      description: 'Were there any notes from the stickersheet?',
      initials: 'AB',
      color: Colors.pink,
    ),
    _ListItemContent(
      title: 'New position',
      name: 'Rachel Been',
      description:
          'I\'ve got exciting news! I\' been speaking with the Home team.',
      initials: 'RB',
      color: Colors.cyan,
    ),
    _ListItemContent(
      title: 'Research?',
      name: 'MH Johnson',
      description: 'Hi! I was wondering if we could talk about a new study?',
      initials: 'MJ',
      color: Colors.orange,
    ),
    _ListItemContent(
      title: 'Reminder: Monday is a holiday',
      name: 'Rich Fulcher',
      description:
          'Don\'t forget that Monday is St Swithins day. The office will be closed',
      initials: 'RF',
      color: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 24),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: grey600),
                child: Icon(icon.icon, size: 16, color: grey600),
              ),
              SizedBox(width: 6),
              Text(
                title.toUpperCase(),
                style: textTheme.title.copyWith(
                  color: Colors.black54,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < _itemContents.length; i++)
          _ListItem(
            content: _itemContents[order[i]],
            time: times[i],
          ),
      ],
    );
  }
}

class _ListItemContent {
  _ListItemContent(
      {this.title,
      this.name,
      this.description,
      this.initials,
      this.color,
      this.attachments});

  final String title;
  final String name;
  final String description;
  final String initials;
  final Color color;
  final Widget attachments;
}

class _ListItem extends StatelessWidget {
  _ListItem({this.content, this.time});

  final _ListItemContent content;
  final String time;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                child: Text(
                  content.initials,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: content.color,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          content.title,
                          style: textTheme.subtitle.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          time,
                          style: textTheme.body1.copyWith(
                            color: grey600,
                            letterSpacing: 0.25,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      content.name,
                      style: textTheme.body1,
                    ),
                    SizedBox(height: 8),
                    Text(
                      content.description,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.body1.copyWith(
                        color: grey600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (content.attachments != null)
          Padding(
              padding: EdgeInsets.only(left: 76), child: content.attachments),
        SizedBox(height: 12),
      ],
    );
  }
}

class _ChipAttachments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        Chip(
          label: Text(
            '10/16 Notes',
            style: textTheme.body1.copyWith(
              color: blue600,
              fontSize: 12,
            ),
          ),
          backgroundColor: blue50,
          avatar: Icon(
            Icons.assignment,
            color: blue600,
          ),
        ),
        SizedBox(width: 8),
        Chip(
          label: Text(
            'Task tracker',
            style: textTheme.body1.copyWith(
              color: green600,
              fontSize: 12,
            ),
          ),
          backgroundColor: blue50,
          avatar: Icon(
            Icons.assessment,
            color: green600,
          ),
        ),
      ],
    );
  }
}
