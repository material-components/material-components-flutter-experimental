import 'package:flutter/material.dart';

class BalanceItem {
  final String name;
  final double primaryAmount;

  const BalanceItem({this.name, this.primaryAmount});
}

/// The [primaryAmount] is the balance of the account in USD.
class AccountItem extends BalanceItem {
  final String accountNumber;

  const AccountItem({String name, double primaryAmount, this.accountNumber})
      : super(name: name, primaryAmount: primaryAmount);
}

/// The [primaryAmount] is the amount due in USD.
class BillItem extends BalanceItem {
  final String dueDate; // TODO: final DateTime dueDate;

  const BillItem({String name, double primaryAmount, this.dueDate})
      : super(name: name, primaryAmount: primaryAmount);
}

/// The [primaryAmount] is the budget cap in USD.
class BudgetItem extends BalanceItem {
  final double amountUsed;

  const BudgetItem({String name, double primaryAmount, this.amountUsed})
      : super(name: name, primaryAmount: primaryAmount);
}

class Models {
  static List<AccountItem> getAccountsModel() {
    return <AccountItem>[
      AccountItem(
        name: 'Checking',
        primaryAmount: 2215.13,
        accountNumber: '1234561234',
      ),
      AccountItem(
        name: 'Home Savings',
        primaryAmount: 8678.88,
        accountNumber: '8888885678',
      ),
      AccountItem(
        name: 'Car Savings',
        primaryAmount: 987.48,
        accountNumber: '8888889012',
      ),
      AccountItem(
        name: 'Vacation',
        primaryAmount: 253.0,
        accountNumber: '1231233456',
      ),
    ];
  }

  static List<BillItem> getBillsModel() {
    return <BillItem>[
      BillItem(
        name: 'RedPay Credit',
        primaryAmount: 45.36,
        dueDate: 'Jan 29',
      ),
      BillItem(
        name: 'Rent',
        primaryAmount: 1200.0,
        dueDate: 'Feb 9',
      ),
      BillItem(
        name: 'TabFine Credit',
        primaryAmount: 87.33,
        dueDate: 'Feb 22',
      ),
      BillItem(
        name: 'ABC Loans',
        primaryAmount: 400.0,
        dueDate: 'Feb 29',
      ),
    ];
  }

  static List<BudgetItem> getBudgetsModel() {
    return <BudgetItem>[
      BudgetItem(
        name: 'Coffee Shops',
        primaryAmount: 70.0,
        amountUsed: 45.49,
      ),
      BudgetItem(
        name: 'Groceries',
        primaryAmount: 170.0,
        amountUsed: 16.45,
      ),
      BudgetItem(
        name: 'Restaurants',
        primaryAmount: 170.0,
        amountUsed: 123.25,
      ),
      BudgetItem(
        name: 'Clothing',
        primaryAmount: 70.0,
        amountUsed: 19.45,
      ),
    ];
  }
}
