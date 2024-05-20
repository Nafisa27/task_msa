import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_msa/database/expense_database.dart';
import 'package:task_msa/controller/expense_controller.dart';
import 'package:task_msa/utils/app_string.dart';

class AddEditExpenseScreen extends StatefulWidget {
  final Expense? expense;
  final int? index;

  const AddEditExpenseScreen({super.key, this.expense, this.index});

  @override
  AddEditExpenseScreenState createState() => AddEditExpenseScreenState();
}

class AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  final ExpenseController expenseController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      descriptionController.text = widget.expense!.description;
      amountController.text = widget.expense!.amount.toString();
      selectedDate.value = widget.expense!.date;
    } else {
      selectedDate.value = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null ? addExpense : editExpense),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: descriptionLabel),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return descriptionValidationMessage;
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(labelText: amount),
                keyboardType: TextInputType.number,
                maxLength: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return amountValidationMessage;
                  }
                  if (double.tryParse(value) == null) {
                    return amountValidationNumberMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Obx(() => ListTile(
                    title: Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate.value)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: _selectDate,
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.expense == null ? add : save),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final description = descriptionController.text;
                    final amount = double.parse(amountController.text);
                    final expense = Expense(
                      description: description,
                      amount: amount,
                      date: selectedDate.value,
                    );
                    if (widget.expense == null) {
                      expenseController.addExpense(expense);
                    } else {
                      expenseController.updateExpense(widget.index!, expense);
                    }
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
}
