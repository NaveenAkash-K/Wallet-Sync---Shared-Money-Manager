import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walletSync/models/expense_model.dart';
import 'package:walletSync/models/income_model.dart';

class Chart extends StatefulWidget {
  const Chart({
    super.key,
    required this.registeredExpense,
    required this.registeredIncome,
  });
  @override
  State<StatefulWidget> createState() {
    return _ChartState();
  }

  final List<Expense> registeredExpense;
  final List<Income> registeredIncome;
}

class _ChartState extends State<Chart> {
  double get availableMoney {
    var expense = 0.0;
    var income = 0.0;
    for (final item in widget.registeredExpense) {
      expense += item.amount;
    }
    for (final item in widget.registeredIncome) {
      income += item.amount;
    }
    return income - expense;
  }

  double get monthExpense {
    var expense = 0.0;
    for (final item in widget.registeredExpense) {
      if (DateFormat('dd/MM/y').parse(item.date.replaceAll(' ', '')).month ==
          DateTime.now().month) {
        expense += item.amount;
      }
    }
    return expense;
  }

  double get dayExpense {
    var expense = 0.0;
    for (final item in widget.registeredExpense) {
      if (DateFormat('dd/MM/y').parse(item.date.replaceAll(' ', '')).day ==
          DateTime.now().day) {
        expense += item.amount;
      }
    }
    return expense;
  }

  double get monthIncome {
    var expense = 0.0;
    for (final item in widget.registeredIncome) {
      if (DateFormat('dd/MM/y').parse(item.date.replaceAll(' ', '')).month ==
          DateTime.now().month) {
        expense += item.amount;
      }
    }
    return expense;
  }

  double get dayIncome {
    var expense = 0.0;
    for (final item in widget.registeredIncome) {
      if (DateFormat('dd/MM/y').parse(item.date.replaceAll(' ', '')).day ==
          DateTime.now().day) {
        expense += item.amount;
      }
    }
    return expense;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      // color: Colors.amber,
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 5),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Total Expense',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat.MMMM().format(DateTime.now()),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20),
                    ),
                    Text(
                      '₹ $monthExpense',
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      ' Today ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20),
                    ),
                    Text(
                      '₹ $dayExpense',
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Column(
                  children: [
                    Text(
                      ' Total Income ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat.MMMM().format(DateTime.now()),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20),
                    ),
                    Text(
                      '₹ $monthIncome',
                      style: const TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      ' Today ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20),
                    ),
                    Text(
                      ' ₹ $dayIncome',
                      style: const TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Available Money',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20),
          ),
          Text(
            ' ₹ $availableMoney',
            style: TextStyle(
                color: availableMoney > 0 ? Colors.green : Colors.red,
                fontSize: 20),
          ),
        ],
      ),
    );
  }
}
