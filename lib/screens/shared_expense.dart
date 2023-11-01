import 'package:flutter/material.dart';

class SharedExpense extends StatefulWidget {
  const SharedExpense({super.key});
  @override
  State<StatefulWidget> createState() => _SharedExpenseState();
}

class _SharedExpenseState extends State<SharedExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Expense"),
      ),
      body: null,
    );
  }
}
