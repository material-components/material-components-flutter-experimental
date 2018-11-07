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
  final List<SingleBillModel> billModels = <SingleBillModel>[
    SingleBillModel(
        name: 'RedPay Credit',
        dueDate: 'Jan 29',
        usdDue: 45.36
    ),
    SingleBillModel(
        name: 'Rent',
        dueDate: 'Feb 9',
        usdDue: 1200.0
    ),
    SingleBillModel(
        name: 'TabFine Credit',
        dueDate: 'Feb 22',
        usdDue: 87.33
    ),
    SingleBillModel(
        name: 'ABC Loans',
        dueDate: 'Feb 29',
        usdDue: 400.0
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          CircleChart(),
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
}