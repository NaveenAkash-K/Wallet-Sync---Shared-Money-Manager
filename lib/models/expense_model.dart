import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

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
  'food': MaterialCommunityIcons.hamburger,
  'education': MaterialCommunityIcons.school,
  'entertainment': MaterialCommunityIcons.theater,
  'transport': MaterialCommunityIcons.bus,
  'health': MaterialCommunityIcons.hospital_box,
  'shopping': MaterialCommunityIcons.shopping,
  'others': MaterialCommunityIcons.bank,
  'upi': MaterialCommunityIcons.bank_transfer,
  'cash': MaterialCommunityIcons.cash
  // 'food': Icons.fastfood,
  // 'education': Icons.book,
  // 'entertainment': Icons.videogame_asset,
  // 'transport': Icons.directions_bike,
  // 'health': Icons.health_and_safety,
  // 'shopping': Icons.shopping_cart,
  // 'others': Icons.currency_rupee_rounded,
  // 'upi': Icons.paypal,
  // 'cash': Icons.payments_outlined
};

class Expense {
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    this.isShared = false,
    this.username,
  }) : icon = expenseCategoryIcon[category.name]!;

  // final String date;

  final String title;
  final String date;
  final String time;
  final bool isShared;
  final String? username;
  final double amount;
  final ExpenseCategory category;
  final String id;
  final IconData icon;
}
