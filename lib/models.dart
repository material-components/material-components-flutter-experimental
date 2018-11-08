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

  const SingleAccountModel({this.name, this.accountNumber, this.usdBalance});
}

class SingleBillModel {
  final String name;
  final String dueDate; // TODO: final DateTime dueDate;
  final double usdDue;

  const SingleBillModel({this.name, this.dueDate, this.usdDue});
}

class SingleBudgetModel {
  final String name;
  final double usdUsed;
  final double usdCap;

  const SingleBudgetModel({this.name, this.usdUsed, this.usdCap});
}

class Models {
  static List<SingleAccountModel> getAccountsModel() {
    return <SingleAccountModel>[
      SingleAccountModel(
          name: 'Checking',
          accountNumber: '1234561234',
          usdBalance: 2215.13
      ),
      SingleAccountModel(
          name: 'Home Savings',
          accountNumber: '8888885678',
          usdBalance: 8678.88
      ),
      SingleAccountModel(
          name: 'Car Savings',
          accountNumber: '8888889012',
          usdBalance: 987.48
      ),
      SingleAccountModel(
          name: 'Vacation',
          accountNumber: '1231233456',
          usdBalance: 253.0
      ),
    ];
  }

  static List<SingleBillModel> getBillsModel() {
    return <SingleBillModel>[
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
  }

  static List<SingleBudgetModel> getBudgetsModel() {
    return <SingleBudgetModel>[
      SingleBudgetModel(
          name: 'Coffee Shops',
          usdUsed: 45.49,
          usdCap: 70.0
      ),
      SingleBudgetModel(
          name: 'Groceries',
          usdUsed: 16.45,
          usdCap: 170.0
      ),
      SingleBudgetModel(
          name: 'Restaurants',
          usdUsed: 123.25,
          usdCap: 170.0
      ),
      SingleBudgetModel(
          name: 'Clothing',
          usdUsed: 19.45,
          usdCap: 70.0
      ),
    ];
  }
}
