import 'package:flutter/widgets.dart';

/// Placeholder for the settings page.
///
/// TODO(clocksmith): this page.
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          Image.asset('assets/logo.png'),
          Image.asset('assets/logo.png'),
          Image.asset('assets/logo.png')
        ]);
  }
}