import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:advanced_components_and_theming/Rally/colors.dart';
import 'package:advanced_components_and_theming/Rally/models.dart';
import 'package:advanced_components_and_theming/Rally/shared/balance_card.dart';
import 'package:advanced_components_and_theming/Rally/shared/circle_chart.dart';

// TODO(clocksmith): Refactor AccountsPage, BillsPage, and BudgetsPage to share more.
class AccountsPage extends StatefulWidget {
  AccountsPage({Key key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> with SingleTickerProviderStateMixin {
  final List<SingleAccountModel> accountModels = Models.getAccountsModel();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          CircleChart(
            centerLabel: "Total",
            centerAmount: _getTotal(),
            total: _getTotal(),
            colors: _getColors(),
            amounts: _getAmounts(),
          ),
          // TODO(clocksmith): Is this actually supposed to be a shadow?
          SizedBox(height: 1.0, child: Container(color: Color(0xA026282F))),
          ListView(
            shrinkWrap: true,
            children: BalanceCard.listFromAccountModels(accountModels),
          )
        ]);
  }

  double _getTotal() {
    return accountModels.fold(0, (double sum, SingleAccountModel next) => sum + next.usdBalance);
  }

  // TODO(clocksmith): map with index
  List<Color> _getColors() {
    List<Color> list = [];
    for (int i = 0; i < accountModels.length; i++) {
      list.add(RallyColors.getAccountColor(i));
    }
    return list;
  }

  List<double> _getAmounts() {
    return accountModels.map((SingleAccountModel m) => m.usdBalance).toList();
  }
}