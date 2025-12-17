import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
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
  Category selectedCategory = Category.food;

  bool isSuccess = true;

  List<Expense> expense = [];

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void onSubmit() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Validation Error"),
          content: Text("Please fill in all fields"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    } else {
      final newExpense = Expense(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: selectedDate,
        category: selectedCategory,
      );
      widget.onCreate(newExpense);
      
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Submission Successfully!"),
          content: Text("Thanks for submitting your expenses"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Ronan The Best"),
            )
          ],
        ),
      );
    }
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
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  controller: _amountController,
                  decoration: InputDecoration(label: Text("Amount")),
                ),
              ),
              SizedBox(width: 10),
              DropdownButton<Category>(
                value: selectedCategory,
                items: Category.values.map((Category category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (Category? value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          DropdownDatePicker(
              dateformatorder: OrderFormat.ydm, // default is myd
              inputDecoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))), // optional
              isDropdownHideUnderline: true, // optional
              isFormValidator: true, // optional
              startYear: 1900, // optional
              endYear: 2020, // optional
              width: 10, // optional
              // selectedDay: 14, // optional
              // selectedMonth: 10, // optional
              // selectedYear: 1993, // optional
              onChangedDay: (value) => print('onChangedDay: $value'),
              onChangedMonth: (value) => print('onChangedMonth: $value'),
              onChangedYear: (value) => print('onChangedYear: $value'),
              //boxDecoration: BoxDecoration(
              // border: Border.all(color: Colors.grey, width: 1.0)), // optional
              // showDay: false,// optional
              dayFlex: 2,// optional
              // locale: "zh_CN",// optional
              // hintDay: 'Day', // optional
              // hintMonth: 'Month', // optional
              // hintYear: 'Year', // optional
              // hintTextStyle: TextStyle(color: Colors.grey), // optional
            ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: onSubmit, child: Text("Submit")),
            ],
          ),
        ],
      ),
    );
  }
}