import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:walletSync/models/expense_model.dart';
import 'package:walletSync/models/income_model.dart';
import 'package:walletSync/screens/new_expense.dart';
import 'package:walletSync/screens/new_income.dart';
import 'package:walletSync/widgets/chart.dart';
import 'package:walletSync/widgets/expense_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Expense> registeredExpense = [];
List<Income> registeredIncome = [];
List<dynamic> transactions = [];

class TransScreen extends StatefulWidget {
  const TransScreen({super.key});
  @override
  State<StatefulWidget> createState() => _TransScreen();
}

class _TransScreen extends State<TransScreen> {
  final firestore = FirebaseFirestore.instance;
  var isFetching = true;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  void removeExpense(item) {
    firestore
        .collection("uid")
        .doc(uid)
        .collection("expense")
        .doc(item.id)
        .delete();
    setState(() {
      transactions.remove(item);
      registeredExpense.remove(item);
    });
  }

  void removeIncome(item) {
    firestore
        .collection("uid")
        .doc(uid)
        .collection("income")
        .doc(item.id)
        .delete();
    setState(() {
      transactions.remove(item);
      registeredIncome.remove(item);
    });
  }

  void orderTransactions() {
    transactions.sort((a, b) {
      final dateA = DateFormat('dd/MM/y').parse(a.date.replaceAll(' ', ''));
      final dateB = DateFormat('dd/MM/y').parse(b.date.replaceAll(' ', ''));

      // Compare the dates first
      int dateComparison = dateB.compareTo(dateA);
      if (dateComparison != 0) {
        return dateComparison;
      }

      // If the dates are the same, compare the times
      final timeA = DateFormat('hh:mm a').parse(a.time);
      final timeB = DateFormat('hh:mm a').parse(b.time);
      // DateFormat.
      return timeB.compareTo(timeA);
    });
  }

  dynamic expenseData;
  dynamic incomeData;

  void loadItem() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final incomeSnapShot =
        await firestore.collection("uid").doc(uid).collection("income").get();

    final expenseSnapShot =
        await firestore.collection("uid").doc(uid).collection("expense").get();

    setState(() {
      isFetching = false;
    });

    if (expenseSnapShot.docs.isNotEmpty) {
      expenseData = expenseSnapShot.docs.asMap();
    }

    if (incomeSnapShot.docs.isNotEmpty) {
      incomeData = incomeSnapShot.docs.asMap();
    }

    final List<Income> incomeLoadedItem = [];
    final List<Expense> expenseLoadedItem = [];
    late ExpenseCategory eCategory;
    late IncomeCategory iCategory;

    if (expenseData != null) {
      for (final item in expenseData.entries) {
        if (item.value['category'] == 'entertainment') {
          eCategory = ExpenseCategory.entertainment;
        } else if (item.value['category'] == 'food') {
          eCategory = ExpenseCategory.food;
        } else if (item.value['category'] == 'transport') {
          eCategory = ExpenseCategory.transport;
        } else if (item.value['category'] == 'health') {
          eCategory = ExpenseCategory.health;
        } else if (item.value['category'] == 'shopping') {
          eCategory = ExpenseCategory.shopping;
        } else if (item.value['category'] == 'others') {
          eCategory = ExpenseCategory.others;
        } else if (item.value['category'] == 'upi') {
          eCategory = ExpenseCategory.upi;
        } else if (item.value['category'] == 'cash') {
          eCategory = ExpenseCategory.cash;
        } else {
          eCategory = ExpenseCategory.education;
        }

        expenseLoadedItem.add(
          Expense(
            id: item.value['id'],
            title: item.value['title'],
            amount: item.value['amount'],
            category: eCategory,
            date: item.value['date'],
            time: item.value['time'],
          ),
        );
      }
    }

    if (incomeData != null) {
      for (final item in incomeData.entries) {
        if (item.value['category'] == 'cash') {
          iCategory = IncomeCategory.cash;
        } else if (item.value['category'] == 'salary') {
          iCategory = IncomeCategory.salary;
        } else if (item.value['category'] == 'upi') {
          iCategory = IncomeCategory.upi;
        } else {
          iCategory = IncomeCategory.others;
        }

        incomeLoadedItem.add(
          Income(
            id: item.value['id'],
            title: item.value['title'],
            amount: item.value['amount'],
            category: iCategory,
            date: item.value['date'],
            time: item.value['time'],
          ),
        );
      }
    }

    setState(() {
      registeredExpense = expenseLoadedItem;
      registeredIncome = incomeLoadedItem;
      transactions = [...registeredExpense, ...registeredIncome];
      orderTransactions();
    });
  }

  @override
  void initState() {
    loadItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money manager'),
        actions: [
          TextButton.icon(
            label: const Text('Logout'),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isFetching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chart(
                  registeredExpense: registeredExpense,
                  registeredIncome: registeredIncome,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ExpenseList(
                    transactions: transactions,
                    registeredExpense: registeredExpense,
                    registeredIncome: registeredIncome,
                    removeExpense: removeExpense,
                    removeIncome: removeIncome,
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        overlayStyle: ExpandableFabOverlayStyle(blur: 6),
        distance: 90,
        child: const Icon(Icons.add),
        children: [
          FloatingActionButton.extended(
            heroTag: 'Expense Screen',
            label: const Text('Expense'),
            icon: const Icon(Icons.attach_money),
            onPressed: () async {
              HapticFeedback.lightImpact();
              final newItem = await Navigator.push<Expense>(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewExpense(),
                ),
              );

              if (newItem == null) {
                return;
              }

              setState(() {
                registeredExpense.add(newItem);
                transactions.add(newItem);
                orderTransactions();
              });
            },
          ),
          FloatingActionButton.extended(
            heroTag: 'Income Screen',
            label: const Text('Income'),
            icon: const Icon(Icons.attach_money),
            onPressed: () async {
              HapticFeedback.lightImpact();

              final newItem = await Navigator.push<Income>(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewIncomeScreen(),
                ),
              );

              if (newItem == null) {
                return;
              }
              setState(() {
                registeredIncome.add(newItem);
                transactions.add(newItem);
                orderTransactions();
              });
            },
          ),
        ],
      ),
    );
  }
}
