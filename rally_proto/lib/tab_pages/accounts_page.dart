import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/models.dart';
import 'package:rally_proto/shared/balance_card.dart';
import 'package:rally_proto/shared/rally_pie_chart.dart';

// TODO(clocksmith): Refactor AccountsPage, BillsPage, and BudgetsPage to share more.
class AccountsPage extends StatefulWidget {
  AccountsPage({Key key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> with SingleTickerProviderStateMixin {
  final List<AccountItem> accountModels = Models.getAccountsModel();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          RallyPieChart(
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
    return accountModels.fold(0, (double sum, AccountItem next) => sum + next.usdBalance);
  }

  List<Color> _getColors() {
    return RallyColors.getAccountColors(accountModels.length);
  }

  List<double> _getAmounts() {
    return accountModels.map((AccountItem m) => m.usdBalance).toList();
  }
}