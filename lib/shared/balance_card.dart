import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rally_proto/colors.dart';
import 'package:rally_proto/formatters.dart';
import 'package:rally_proto/models.dart';
import 'package:rally_proto/shared/vertical_fractional_bar.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  static BalanceCard fromAccountModel(SingleAccountModel model, int i) {
      return BalanceCard(
        suffix: Icon(Icons.chevron_right, color: Colors.grey),
        title: model.name,
        subtitle: '• • • • • • ' + model.accountNumber.substring(6),
        indicatorColor: RallyColors.getAccountColor(i),
        indicatorFraction: 1.0,
        usdAmount: model.usdBalance,
      );
  }

  static List<BalanceCard> listFromAccountModels(List<SingleAccountModel> models) {
    List<BalanceCard> list = [];
    for (int i = 0; i < models.length; i++) {
      list.add(BalanceCard.fromAccountModel(models[i], i));
    }
    return list;
  }

  const BalanceCard({
    @required this.indicatorColor,
    @required this.indicatorFraction,
    @required this.title,
    @required this.subtitle,
    @required this.usdAmount,
    @required this.suffix,
  });

  final Color indicatorColor;
  final double indicatorFraction;
  final String title;
  final String subtitle;
  final double usdAmount;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 68.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 67.0,
              child: Row(
                children: <Widget>[
                  Padding(
                    child: VerticalFractionalBar(
                        color: indicatorColor,
                        fraction: indicatorFraction
                    ),
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title, style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0)),
                      Text(subtitle, style: Theme.of(context).textTheme.body1.copyWith(color: RallyColors.gray60a))
                    ],
                  ),
                  Spacer(),
                  Text('\$ ' + Formatters.usd.format(usdAmount),
                      style: Theme.of(context).textTheme.body2.copyWith(
                          fontSize: 20.0,
                          color: RallyColors.gray)
                  ),
                  SizedBox(width: 32.0, child: suffix)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: SizedBox(
                  height: 1.0,
                  child: Container(color: Color(0xAA282828))
              ),
            )
          ],
        )
    );
  }
}