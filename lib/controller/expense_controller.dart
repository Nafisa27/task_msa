import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:task_msa/database/expense_database.dart';


class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  late Box box;

  @override
  void onInit() {
    super.onInit();
    box = Hive.box('expenses');
    loadExpenses();
  }

  void loadExpenses() {
    expenses.value = List<Expense>.from(box.values);
  }

  void addExpense(Expense expense) {
    box.add(expense);
    expenses.add(expense);
  }

  void updateExpense(int index, Expense expense) {
    box.putAt(index, expense);
    expenses[index] = expense;
  }

  void deleteExpense(int index) {
    box.deleteAt(index);
    expenses.removeAt(index);
  }
}
