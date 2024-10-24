import 'package:bookingcars/MVVM/Models/expenses/expenses_data_model.dart';
import 'package:bookingcars/MVVM/View%20Model/expenses_data_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesDataView extends StatefulWidget {
  const ExpensesDataView({super.key});

  @override
  State<ExpensesDataView> createState() => _ExpensesDataViewState();
}

class _ExpensesDataViewState extends State<ExpensesDataView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpensesViewModel>(context, listen: false).fetchExpenses();
    });
  }

  Widget buildTable(ExpensesViewModel expensesViewModel) {
    return Infowidget(builder: (context, deviceInfo) {
      return SizedBox(
        width: deviceInfo.screenWidth,
        height: deviceInfo.screenHeight,
        child: Scrollbar(
          thumbVisibility: true, // Show scrollbar thumb for vertical scrolling
          child: SingleChildScrollView(
            child: Scrollbar(
              thumbVisibility: true, // Show scrollbar thumb for horizontal scrolling
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: deviceInfo.screenWidth,
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.blue),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Customer Name')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Car Details')),
                      DataColumn(label: Text('Expenses Date')),
                      DataColumn(label: Text('Cost')),
                      DataColumn(label: Text('Remaining')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: expensesViewModel.expenses.map<DataRow>((expense) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(expense.customerName ?? 'N/A')),
                          DataCell(Text(expense.description ?? 'N/A')),
                          DataCell(Text(expense.carDetails ?? 'N/A')),
                          DataCell(Text(expense.expensesDate.toString())),
                          DataCell(Text(expense.cost?.toString() ?? 'N/A')),
                          DataCell(Text(expense.remaining?.toString() ?? 'N/A')),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(context, expense, expensesViewModel);
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Implement add dialog similar to CarsDataView
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Center(
        child: Consumer<ExpensesViewModel>(builder: (context, expensesViewModel, child) {
          if (expensesViewModel.isLoading) {
            return CircularProgressIndicator();
          }

          return buildTable(expensesViewModel);
        }),
      ),
    );
  }

  void _showEditDialog(BuildContext context, ExpensesDataModel expense, ExpensesViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Expense'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(text: expense.customerName),
                  onChanged: (value) {
                    expense.customerName = value;
                  },
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                ),
                TextField(
                  controller: TextEditingController(text: expense.description),
                  onChanged: (value) {
                    expense.description = value;
                  },
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: TextEditingController(text: expense.carDetails),
                  onChanged: (value) {
                    expense.carDetails = value;
                  },
                  decoration: const InputDecoration(labelText: 'Car Details'),
                ),
                TextField(
                  controller: TextEditingController(text: expense.expensesDate.toString()),
                  onChanged: (value) {
                    expense.expensesDate = DateTime.parse(value);
                  },
                  decoration: const InputDecoration(labelText: 'Expenses Date'),
                ),
                TextField(
                  controller: TextEditingController(text: expense.cost.toString()),
                  onChanged: (value) {
                    expense.cost = value;
                  },
                  decoration: const InputDecoration(labelText: 'Cost'),
                ),
                TextField(
                  controller: TextEditingController(text: expense.remaining.toString()),
                  onChanged: (value) {
                    expense.remaining = value;
                  },
                  decoration: const InputDecoration(labelText: 'Remaining'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                viewModel.updateExpense(expense);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
