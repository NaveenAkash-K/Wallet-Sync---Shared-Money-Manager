import 'package:flutter/material.dart';

enum IncomeCategory { salary, others, cash, upi }

Map<String, IconData> incomeCategoryIcon = {
  'salary': Icons.credit_card,
  'cash': Icons.payments_outlined,
  'others': Icons.currency_rupee,
  'upi': Icons.paypal,
};

class Income {
  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
  }) : icon = incomeCategoryIcon[category.name]!;

  // final String date;

  final String title;
  final String date;
  final String time;
  final double amount;
  final IncomeCategory category;
  final String id;
  final IconData icon;
}
