import 'package:expenses_application/models/expense.dart';
import 'package:flutter/material.dart';

import 'expenses/expense_form.dart';
import 'expenses/expenses.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Expense> expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void onAddClicked(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (c) => ExpenseForm(
        onCreate: _addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => onAddClicked(context),
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesView(expenses: expenses),
          ),
        ],
      ),
    );
  }
}