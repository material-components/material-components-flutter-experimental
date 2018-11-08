import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/models.dart';
import 'package:rally_proto/shared/balance_card.dart';
import 'package:rally_proto/shared/circle_chart.dart';

class BillsPage extends StatefulWidget {
  BillsPage({Key key}) : super(key: key);

  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> with SingleTickerProviderStateMixin {
  final List<SingleBillModel> billModels = Models.getBillsModel();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          CircleChart(
            centerLabel: "Due",
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
    for (int i = 0; i < billModels.length; i++) {
      list.add(_buildBalanceCard(billModels[i], i));
    }
    return list;
  }

  BalanceCard _buildBalanceCard(SingleBillModel billModel, int i) {
    return BalanceCard(
      suffix: Icon(Icons.chevron_right, color: Colors.grey),
      title: billModel.name,
      subtitle: billModel.dueDate,
      indicatorColor: RallyColors.getBillColor(i),
      indicatorFraction: 1.0,
      usdAmount: billModel.usdDue,
    );
  }

  double _getTotal() {
    return billModels.fold(0, (double sum, SingleBillModel next) => sum + next.usdDue);
  }

  List<Color> _getColors() {
    List<Color> list = [];
    for (int i = 0; i < billModels.length; i++) {
      list.add(RallyColors.getBillColor(i));
    }
    return list;
  }

  List<double> _getAmounts() {
    return billModels.map((SingleBillModel m) => m.usdDue).toList();
  }
}