import 'package:flutter/material.dart';

class BalanceCardModel {
  final Color indicatorColor;
  final double indicatorFraction;
  final String title;
  final String subtitle;
  final double usdAmount;
  final Widget suffix;

  const BalanceCardModel(
      this.indicatorColor,
      this.indicatorFraction,
      this.title,
      this.subtitle,
      this.usdAmount,
      this.suffix,
  );
}

class SingleAccountModel {
  final String name;
  final String accountNumber;
  final double usdBalance;

  const SingleAccountModel(this.name, this.accountNumber, this.usdBalance);
}

class SingleBillModel {
  final String name;
  final DateTime dueDate;
  final double usdDue;

  const SingleBillModel(this.name, this.dueDate, this.usdDue);
}

class SingleBudgetModel {
  final String name;
  final double usdUsed;
  final double usdAlotted;

  const SingleBudgetModel(this.name, this.usdUsed, this.usdAlotted);
}


