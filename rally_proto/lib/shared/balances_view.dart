import 'package:flutter/widgets.dart';
import 'package:rally_proto/models.dart';

typedef double WholeAmountMapper(BalanceItem item);
typedef double FractionalAmountMapper(BalanceItem item);


class BalancesView extends StatelessWidget {
  BalancesView({this.items, this.colors,})
  : assert(items.length == colors.length);

  /// The items to represent in this view.
  final List<BalanceItem> items;

  /// The colors to assign each item.
  ///
  /// This list must have the same length as [items].
  final List<Color> colors;

  final String highlightedValueLabel;

  final WholeAmountMapper wholeAmountMapper;

  final FractionalAmountMapper fractionalAmountMapper;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          RallyPieChart(
            centerLabel: highlightedValueLabel,
            centerAmount: items.fold(0, (double sum, BalanceItem next) => sum + wholeAmountMapper(next)),
            total: items.fold(0, (double sum, BalanceItem next) => sum + wholeAmountMapper(next))
            colors: colors,
            amounts: items.map(singleAmountMapper)
          ),
          // TODO(clocksmith): Is this actually supposed to be a shadow?
          SizedBox(height: 1.0, child: Container(color: Color(0xA026282F))),
          ListView(
            shrinkWrap: true,
            children: BalanceCard.listFromAccountModels(accountModels),
          )
        ]);
  }
}