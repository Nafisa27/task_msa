import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_msa/controller/expense_controller.dart';
import 'package:task_msa/widget/expense_item.dart';

import 'add_edit_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.put(ExpenseController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: expenseController.expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenseController.expenses[index];
                  return ExpenseItem(
                    expense: expense,
                    onEdit: () {
                      Get.to(
                          AddEditExpenseScreen(expense: expense, index: index));
                    },
                    onDelete: () {
                      expenseController.deleteExpense(index);
                    },
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Add Expense'),
              onPressed: () {
                Get.to(AddEditExpenseScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
