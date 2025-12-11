import 'package:expenses_application/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense expense) onCreate;

  const ExpenseForm({super.key, required this.onCreate});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  bool isSuccess = true;

  List<Expense> expense = [];

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void onSubmit() {
    final newExpense = Expense(
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: selectedDate,
      category: Category.food,
    );
    widget.onCreate(newExpense);
    Navigator.pop(context);
  }

  void onCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: _amountController,
                  decoration: InputDecoration(label: Text("Amount")),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
              SizedBox(width: 10),
              isSuccess ? ShowDialogSuccess() : ShowDialogFailure(),
            ],
          ),
        ],
      ),
    );
  }
}


class ShowDialogSuccess extends StatelessWidget{
  const ShowDialogSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child)
  }
}

class ShowDialogFailure extends StatelessWidget{
  const ShowDialogFailure({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Je");
  }
}