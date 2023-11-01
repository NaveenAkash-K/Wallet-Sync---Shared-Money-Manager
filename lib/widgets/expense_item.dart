import 'package:flutter/material.dart';
import 'package:walletSync/models/income_model.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.index,
    required this.transactions,
  });
  final int index;
  final List<dynamic> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primary,
      ),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryContainer),
            height: 40,
            width: 40,
            child: Icon(
              transactions[index].icon,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactions[index].title,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    transactions[index].time,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    transactions[index].date,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transactions[index].category is IncomeCategory
                    ? '₹ + ${transactions[index].amount}'
                    : '₹ - ${transactions[index].amount}',
                // '₹ ${transactions[index].amount}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: transactions[index].category is IncomeCategory
                        ? Colors.green
                        : Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
