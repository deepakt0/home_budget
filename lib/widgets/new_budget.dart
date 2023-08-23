import 'package:flutter/material.dart';
import 'package:home_budget/models/budget.dart';

class NewBudget extends StatefulWidget {
  const NewBudget({super.key, required this.onAddBudget});

  final void Function(Budget budget) onAddBudget;

  @override
  State<StatefulWidget> createState() {
    return _NewBudgetState();
  }
}

class _NewBudgetState extends State<NewBudget> {
  final _titleController = TextEditingController();
  final _availableAmountController = TextEditingController();
  final _carryoverBalanceController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  final _availableAmount = 0.0;
  final _carryoverBalance = 0.0;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;

    if (amountInvalid ||
        _selectedDate == null ||
        _institutionController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please make sure a valid amount, date and store/location was entered'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
      return;
    }

    widget.onAddExpense(
      Expense(
          details: _detailsController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory,
          subCategory: _selectedSubCategory,
          institution: _institutionController.text,
          paymentMethod: _selectedPymtMethod),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _availableAmountController.dispose();
    _carryoverBalanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              DropdownButton<String>(
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    if (_selectedCategory != categories.indexOf(value)) {
                      _selectedCategory = categories.indexOf(value);
                      _selectedSubCategory = 0;
                    }
                  });
                },
                value: categories[_selectedCategory],
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
              ),
              const SizedBox(
                width: 16,
              ),
              DropdownButton<String>(
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedSubCategory =
                        subCategories[_selectedCategory].indexOf(value);
                  });
                },
                value: subCategories[_selectedCategory][_selectedSubCategory],
                items: subCategories[_selectedCategory]
                    .map((subCategory) => DropdownMenuItem(
                          value: subCategory,
                          child: Text(
                            subCategory,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          TextField(
            controller: _detailsController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Details/Remarks'),
            ),
          ),
          TextField(
            controller: _institutionController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Store/Company/Location'),
            ),
          ),
          Row(
            children: [
              DropdownButton<String>(
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    if (_selectedPymtMethod != paymentMethods.indexOf(value)) {
                      _selectedPymtMethod = paymentMethods.indexOf(value);
                    }
                  });
                },
                value: paymentMethods[_selectedPymtMethod],
                items: paymentMethods
                    .map((paymentMethod) => DropdownMenuItem(
                          value: paymentMethod,
                          child: Text(paymentMethod),
                        ))
                    .toList(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
