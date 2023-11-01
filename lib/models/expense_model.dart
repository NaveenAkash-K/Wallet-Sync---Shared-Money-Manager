import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  entertainment,
  education,
  transport,
  health,
  shopping,
  upi,
  cash,
  others
}

Map<String, IconData> expenseCategoryIcon = {
  'food': Icons.fastfood,
  'education': Icons.book,
  'entertainment': Icons.videogame_asset,
  'transport': Icons.directions_bike,
  'health': Icons.health_and_safety,
  'shopping': Icons.shopping_cart,
  'others': Icons.currency_rupee_rounded,
  'upi': Icons.paypal,
  'cash': Icons.payments_outlined
};

class Expense {
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
  }) : icon = expenseCategoryIcon[category.name]!;

  // final String date;

  final String title;
  final String date;
  final String time;

  final double amount;
  final ExpenseCategory category;
  final String id;
  final IconData icon;
}
