import 'package:expenses_application/ui/expenses/expense_statistic.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<ExpensesView> createState() {
    return _ExpensesViewState();
  }
}

class _ExpensesViewState extends State<ExpensesView> {
  final List<Expense> _expense = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final allExpenses = [..._expense, ...widget.expenses];

    return Column(
      children: [
        ExpenseStatistic(expenses: allExpenses),
        Expanded(
          child: ListView.builder(
            itemCount: allExpenses.length,
            itemBuilder: (context, index) {
              final expense = allExpenses[index];
              return Dismissible(
                key: Key(expense.title + expense.date.toString()),
                onDismissed: (direction) {
                  setState(() {
                    _expense.remove(expense);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${expense.title} dismissed'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          setState(() {
                            _expense.add(expense);
                          });
                        },
                      ),
                    ),
                  );
                },
                child: ExpenseItem(expense: expense),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  IconData get expenseIcon {
    switch (expense.category) {
      case Category.food:
        return Icons.free_breakfast;
      case Category.travel:
        return Icons.travel_explore;
      case Category.leisure:
        return Icons.holiday_village;
      case Category.work:
        return Icons.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${expense.amount.toStringAsPrecision(2)} \$"),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(expenseIcon),
                  ),
                  Text(
                    '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
