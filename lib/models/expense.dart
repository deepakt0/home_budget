import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

List<String> categories = [
  'Bills & Utilities',
  'Food',
  'Transportation',
  'Education',
  'Leisure',
];

//Each of this will contain a list of sub categories for a specific category
//So, order is important and cannot be changed unless equivalent change is made
//for categories as well
List<List<String>> subCategories = [
  //For 'Bills & Utilities',
  ['Electricity', 'Gas'],
  //For 'Food',
  ['Groceries', 'Eatout', 'Drinks'],
  //For 'Transportation',
  ['Gas', 'Tickets', 'Maintenance', 'Parking'],
  //For 'Education',
  ['Fees', 'Books & Materials', 'Trip Fees'],
  //For 'Leisure',
  ['Movies', 'Trips & Outings', 'Tickets', 'Travel Accommodation'],
];

List<String> paymentMethods = [
  'BOA Checking',
  'Chase Checking',
  'DT Citi Card',
  'AMEX Card',
  'TT Citi Card',
  'TT Discover',
  'Agastya Discover',
  'CostCo Gift Card',
  'Amazon Gift Card',
  'Amazon Card',
  'Cash'
];

const categoryIcons = {
  0: Icons.receipt,
  1: Icons.lunch_dining_rounded,
  2: Icons.emoji_transportation,
  3: Icons.book,
  4: Icons.movie,
};

class Expense {
  final String id;
  final double amount;
  final DateTime date;
  final String institution;
  final int category;
  final int subCategory;
  final String details;
  final int paymentMethod;

  Expense(
      {required this.amount,
      required this.date,
      required this.category,
      required this.subCategory,
      required this.institution,
      required this.paymentMethod,
      required this.details})
      : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  final int category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
