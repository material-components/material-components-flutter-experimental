import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/formatters.dart';
import 'package:rally_proto/models.dart';
import 'package:rally_proto/shared/balance_card.dart';
import 'package:rally_proto/shared/circle_chart.dart';

class BudgetsPage extends StatefulWidget {
  BudgetsPage({Key key}) : super(key: key);

  @override
  _BudgetsPageState createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> with SingleTickerProviderStateMixin {
  final List<SingleBudgetModel> budgetModels = Models.getBudgetsModel();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          CircleChart(
            centerLabel: "Left",
            centerAmount: _getTotal() - _getUsed(),
            total: _getTotal(),
            colors: _getColors(),
            amounts: _getAmounts(),
          ),
          SizedBox(height: 1.0, child: Container(color: Color(0xA026282F))),
          ListView(
            shrinkWrap: true,
            children: _buildBalanceCards(context),
          )
        ]);
  }

  List<BalanceCard> _buildBalanceCards(BuildContext context) {
    List<BalanceCard> list = [];
    for (int i = 0; i < budgetModels.length; i++) {
      list.add(_buildBalanceCard(budgetModels[i], i, context));
    }
    return list;
  }

  BalanceCard _buildBalanceCard(SingleBudgetModel budgetModel, int i, BuildContext context) {
    return BalanceCard(
      suffix: Text(' LEFT', style: Theme.of(context).textTheme.body1.copyWith(color: RallyColors.gray60a, fontSize: 10.0)),
      title: budgetModel.name,
      subtitle: Formatters.usdWithSign.format(budgetModel.usdUsed) + ' / ' + Formatters.usdWithSign.format(budgetModel.usdCap),
      indicatorColor: RallyColors.getBudgetColor(i),
      indicatorFraction: budgetModel.usdUsed / budgetModel.usdCap,
      usdAmount: budgetModel.usdCap - budgetModel.usdUsed,
    );
  }

  double _getTotal() {
    return budgetModels.fold(0, (double sum, SingleBudgetModel next) => sum + next.usdCap);
  }

  double _getUsed() {
    return budgetModels.fold(0, (double sum, SingleBudgetModel next) => sum + next.usdUsed);
  }

  List<Color> _getColors() {
    List<Color> list = [];
    for (int i = 0; i < budgetModels.length; i++) {
      list.add(RallyColors.getBudgetColor(i));
    }
    return list;
  }

  List<double> _getAmounts() {
    return budgetModels.map((SingleBudgetModel m) => m.usdUsed).toList();
  }
}