import 'package:flutter/material.dart';
import 'package:walletSync/models/expense_model.dart';
import 'package:walletSync/models/income_model.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({
    super.key,
    required this.registeredExpense,
    required this.registeredIncome,
    required this.transactions,
  });
  final List<Income> registeredIncome;
  final List<Expense> registeredExpense;
  final List<dynamic> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
    );
  }
}
