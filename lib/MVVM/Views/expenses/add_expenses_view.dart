import 'package:bookingcars/MVVM/Models/expenses/expenses_data_model.dart';
import 'package:bookingcars/MVVM/View%20Model/expenses_data_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<AddExpenseView> createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _carDetailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _remainingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Infowidget(builder: (context, device) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).add_expenses),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _customerNameController,
                decoration:
                    InputDecoration(labelText: S.of(context).customer_name),
              ),
              TextField(
                controller: _descriptionController,
                decoration:
                    InputDecoration(labelText: S.of(context).description),
              ),
              TextField(
                controller: _carDetailsController,
                decoration:
                    InputDecoration(labelText: S.of(context).car_details),
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: S.of(context).date),
              ),
              TextField(
                controller: _costController,
                decoration: InputDecoration(labelText: S.of(context).cost),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _remainingController,
                decoration: InputDecoration(labelText: S.of(context).remaining),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Container(
                width: device.screenWidth * 0.7,
                height: device.screenHeight * 0.05,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MaterialButton(
                  onPressed: () {
                    _addExpense(context);
                  },
                  child: Text(S.of(context).save),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _addExpense(BuildContext context) {
    final expensesViewModel =
        Provider.of<ExpensesViewModel>(context, listen: false);

    final newExpense = ExpensesDataModel(
      customerName: _customerNameController.text,
      description: _descriptionController.text,
      carDetails: _carDetailsController.text,
      expensesDate: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
      cost: _costController.text,
      remaining: _remainingController.text,
    );

    // Add the new expense to the view model
    expensesViewModel.addExpense(newExpense).then((_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        // ignore: use_build_context_synchronously
        SnackBar(content: Text(S.of(context).expense_added_successfully)),
      );
      // Clear the text fields after adding the expense
      _clearFields();
    }).catchError((error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add expense: $error')),
      );
    });
  }

  void _clearFields() {
    _customerNameController.clear();
    _descriptionController.clear();
    _carDetailsController.clear();
    _dateController.clear();
    _costController.clear();
    _remainingController.clear();
  }
}
