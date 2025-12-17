import 'package:expenses_application/models/expense.dart';
import 'package:expenses_application/ui/expenses/category_cart.dart';
import 'package:flutter/material.dart';

class ExpenseStatistic extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseStatistic({super.key, required this.expenses});

  double getTotalByCategory(Category category) {
    return expenses
        .where((expense) => expense.category == category)
        .fold<double>(0.0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 120,
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CategoryCart(
            icon: Icons.free_breakfast,
            label: "Food",
            amount: getTotalByCategory(Category.food),
          ),
          CategoryCart(
            icon: Icons.travel_explore,
            label: "Travel",
            amount: getTotalByCategory(Category.travel),
          ),
          CategoryCart(
            icon: Icons.holiday_village,
            label: "Leisure",
            amount: getTotalByCategory(Category.leisure),
          ),
          CategoryCart(
            icon: Icons.work,
            label: "Work",
            amount: getTotalByCategory(Category.work),
          ),
        ],
      ),
    );
  }
}