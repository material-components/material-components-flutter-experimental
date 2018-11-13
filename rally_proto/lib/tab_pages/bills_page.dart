import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/models.dart';
import 'package:rally_proto/shared/balance_card.dart';
import 'package:rally_proto/shared/rally_pie_chart.dart';

class BillsPage extends StatefulWidget {
  BillsPage({Key key}) : super(key: key);

  @override
  _BillsPageState createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> with SingleTickerProviderStateMixin {
  final List<BillItem> billModels = Models.getBillsModel();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          RallyPieChart(
            centerLabel: "Due",
            centerAmount: _getTotal(),
            total: _getTotal(),
            colors: _getColors(),
            amounts: _getAmounts(),
          ),
          SizedBox(height: 1.0, child: Container(color: Color(0xA026282F))),
          ListView(
            // TODO(clocksmith): Is this needed? If so, why?
            shrinkWrap: true,
            children: BalanceCard.listFromBillModels(billModels),
          )
        ]);
  }


  double _getTotal() {
    return billModels.fold(0, (double sum, BillItem next) => sum + next.usdDue);
  }

  List<Color> _getColors() {
    return RallyColors.getBillColors(billModels.length);
  }

  List<double> _getAmounts() {
    return billModels.map((BillItem m) => m.usdDue).toList();
  }
}