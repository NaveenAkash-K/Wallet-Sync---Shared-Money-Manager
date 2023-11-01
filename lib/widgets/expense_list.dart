import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:walletSync/models/expense_model.dart';
import 'package:walletSync/models/income_model.dart';
import 'package:walletSync/widgets/expense_item.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ExpenseList extends StatelessWidget {
  ExpenseList({
    super.key,
    required this.transactions,
    required this.registeredExpense,
    required this.registeredIncome,
    required this.removeExpense,
    required this.removeIncome,
  });

  List<dynamic> transactions;
  List<Expense> registeredExpense;
  List<Income> registeredIncome;
  final void Function(Expense item) removeExpense;
  final void Function(Income item) removeIncome;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          "No expense or income. That's wierd",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Dismissible(
          movementDuration: Duration(milliseconds: 220),
          secondaryBackground: Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Theme.of(context).colorScheme.errorContainer,
            child: Row(
              children: [
                const Spacer(),
                Text(
                  'Delete Item',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          key: ValueKey(transactions[index].id),
          background: Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: Theme.of(context).colorScheme.errorContainer,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 10),
                Text(
                  'Delete Item',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                ),
                const Spacer(),
              ],
            ),
          ),
          confirmDismiss: (DismissDirection direction) async {
            // loadItem();
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Confirm?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  content: Text(
                    "Are you sure you wish to delete this item?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("CANCEL"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.errorContainer,
                          foregroundColor:
                              Theme.of(context).colorScheme.onErrorContainer),
                      child: const Text("DELETE"),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            if (transactions[index] is Income) {
              removeIncome(transactions[index]);
            } else {
              removeExpense(transactions[index]);
            }
          },
          child: Column(
            children: [
              ExpenseItem(
                transactions: transactions,
                index: index,
              ),
              if (index == transactions.length - 1) const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }
}
