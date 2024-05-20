import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'expense_database.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  Expense({required this.description, required this.amount, required this.date});
}

class ExpenseProvider with ChangeNotifier {
  late Box<Expense> _expenseBox;

  ExpenseProvider() {
    _expenseBox = Hive.box<Expense>('expenses');
  }

  List<Expense> get expenses => _expenseBox.values.toList();

  void addExpense(Expense expense) {
    _expenseBox.add(expense);
    notifyListeners();
  }
}
