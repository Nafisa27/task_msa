import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_msa/controller/expense_controller.dart';
import 'package:task_msa/utils/app_string.dart';
import 'package:task_msa/widget/expense_item.dart';

import 'add_edit_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.put(ExpenseController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(expensesTitle),
        ),
        body: Obx(() {
          return Column(
            children: [
              Expanded(
                  child: expenseController.expenses.isEmpty
                      ? const Center(
                          child: Text(
                            noExpensesMessage,
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: expenseController.expenses.length,
                          itemBuilder: (context, index) {
                            final expense = expenseController.expenses[index];
                            return ExpenseItem(
                              expense: expense,
                              onEdit: () {
                                Get.to(AddEditExpenseScreen(
                                    expense: expense, index: index));
                              },
                              onDelete: () {
                                expenseController.deleteExpense(index);
                              },
                            );
                          },
                        )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text(addExpense),
                  onPressed: () {
                    Get.to(const AddEditExpenseScreen());
                  },
                ),
              ),
            ],
          );
        }));
  }
}
