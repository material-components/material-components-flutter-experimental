import 'package:flutter/widgets.dart';
import 'package:rally_proto/models.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<SingleAccountModel> accountModels = Models.getAccountsModel();
  final List<SingleBillModel> billModels = Models.getBillsModel();
  final List<SingleBudgetModel> budgetModels = Models.getBudgetsModel();

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