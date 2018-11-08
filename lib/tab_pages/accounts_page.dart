import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/models.dart';
import 'package:rally_proto/shared/balance_card.dart';
import 'package:rally_proto/shared/circle_chart.dart';

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
          SizedBox(height: 1.0, child: Container(color: Color(0xA026282F))),
          ListView(
            shrinkWrap: true,
            children: _buildBalanceCards(),
          )
        ]);
  }

  List<BalanceCard> _buildBalanceCards() {
    List<BalanceCard> list = [];
    for (int i = 0; i < accountModels.length; i++) {
      list.add(_buildBalanceCard(accountModels[i], i));
    }
    return list;
  }

  BalanceCard _buildBalanceCard(SingleAccountModel accountModel, int i) {
    return BalanceCard(
      suffix: Icon(Icons.chevron_right, color: Colors.grey),
      title: accountModel.name,
      subtitle: '• • • • • • ' + accountModel.accountNumber.substring(6),
      indicatorColor: RallyColors.getAccountColor(i),
      indicatorFraction: 1.0,
      usdAmount: accountModel.usdBalance,
    );
  }

  double _getTotal() {
    return accountModels.fold(0, (double sum, SingleAccountModel next) => sum + next.usdBalance);
  }

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