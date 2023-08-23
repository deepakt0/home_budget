import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

//Each of this will contain a list of sub categories for a specific category
//So, order is important and cannot be changed unless equivalent change is made
//for categories as well

class Budget {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final double availableAmount;
  final double budgetAmount;
  final double carryoverBalance;
  final bool active;
  List<Bucket> buckets = [];

  Budget({required this.title,
    required this.startDate,
    required this.endDate,
    required this.availableAmount,
    required this.budgetAmount,
    required this.carryoverBalance})
      : id = uuid.v4(),
        active = true;

  String get formattedStartDate {
    return formatter.format(startDate);
  }

  String get formattedEndDate {
    return formatter.format(endDate);
  }
}

class Bucket {
  final String id;
  final int category;
  final double allocatedAmount;
  final double carryoverBalance;
  final int expenseCount;
  final double expensesAmount;

  Bucket({
    required this.category,
    required this.allocatedAmount,
    required this.carryoverBalance,
  })
      : id = uuid.v4(),
        expenseCount = 0,
        expensesAmount = 0.0;

}
