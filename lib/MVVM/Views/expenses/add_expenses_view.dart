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
          title: Text(S.of(context).add_expenses,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).add_expenses,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _customerNameController,
                          decoration: InputDecoration(
                            labelText: S.of(context).customer_name,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.blue),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: S.of(context).description,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.description,
                                color: Colors.blue),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _carDetailsController,
                          decoration: InputDecoration(
                            labelText: S.of(context).car_details,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.directions_car,
                                color: Colors.blue),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: S.of(context).date,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.calendar_today,
                                color: Colors.blue),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                          onTap: () async {
                            // Hide keyboard
                            FocusScope.of(context).requestFocus(FocusNode());

                            // Show date picker
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null) {
                              setState(() {
                                _dateController.text =
                                    "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _costController,
                          decoration: InputDecoration(
                            labelText: S.of(context).cost,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.attach_money,
                                color: Colors.blue),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _remainingController,
                          decoration: InputDecoration(
                            labelText: S.of(context).remaining,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.account_balance_wallet,
                                color: Colors.blue),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: device.screenWidth * 0.7,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _addExpense(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.save),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).save,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
