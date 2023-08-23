import 'package:flutter/material.dart';
import 'package:home_budget/models/expense.dart';
import 'package:home_budget/widgets/chart/chart.dart';
import 'package:home_budget/widgets/expenses_list/expenses_list.dart';
import 'package:home_budget/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        details: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: 3,
        subCategory: 1,
        institution: 'Udemy',
        paymentMethod: 2),
    Expense(
        details: 'Adi movie with friends',
        amount: 12.95,
        date: DateTime.now(),
        category: 4,
        subCategory: 1,
        institution: 'Cinemark',
        paymentMethod: 2),
    Expense(
        details: 'Agastya B\'Day Dinner',
        amount: 69.55,
        date: DateTime.now(),
        category: 1,
        subCategory: 1,
        institution: 'Cantina Louie',
        paymentMethod: 4),
    Expense(
        details: 'Groceries',
        amount: 27.83,
        date: DateTime.now(),
        category: 1,
        subCategory: 0,
        institution: 'Aldi',
        paymentMethod: 3),
    Expense(
        details: 'CRV Gas at Costco',
        amount: 35.86,
        date: DateTime.now(),
        category: 2,
        subCategory: 0,
        institution: 'CostCo',
        paymentMethod: 7),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    //Get rid of any existing snackbars to avoid stacking them up on multiple deletions
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  @override
  Widget build(BuildContext context) {
    //Display this message if there are no expenses yet
    Widget mainContent =
        const Center(child: Text('No expenses found. Start adding some.'));

    //If any expenses are found, show those...
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
