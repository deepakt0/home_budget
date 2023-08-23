import 'package:flutter/material.dart';
import 'package:home_budget/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  categories[expense.category],
                  //style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text(' - '),
                Text(subCategories[expense.category][expense.subCategory]),
                const Text(' @ '),
                Text(expense.institution),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(paymentMethods[expense.paymentMethod]),
                const Spacer(),
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Text(expense.formattedDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
