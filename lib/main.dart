import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_msa/feature/add_edit_expense_screen.dart';
import 'package:task_msa/database/expense_database.dart';
import 'package:task_msa/feature/home_screen.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox('expenses');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/add_edit', page: () => const AddEditExpenseScreen()),
      ],
    );
  }
}
