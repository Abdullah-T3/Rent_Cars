import 'package:bookingcars/MVVM/Models/expenses/expenses_data_model.dart';
import 'package:bookingcars/MVVM/View%20Model/expenses_data_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesDataView extends StatefulWidget {
  const ExpensesDataView({super.key});

  @override
  State<ExpensesDataView> createState() => _ExpensesDataViewState();
}

class _ExpensesDataViewState extends State<ExpensesDataView> {
  late ScrollController _verticalScrollController;
  late ScrollController _horizontalScrollController;

  @override
  void initState() {
    super.initState();
    _verticalScrollController = ScrollController();
    _horizontalScrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpensesViewModel>(context, listen: false).fetchExpenses();
    });
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  Widget buildTable(ExpensesViewModel expensesViewModel) {
    return Infowidget(builder: (context, deviceInfo) {
      return SizedBox(
        width: deviceInfo.screenWidth,
        height: deviceInfo.screenHeight,
        child: Scrollbar(
          controller: _verticalScrollController, // Attach vertical ScrollController
          thumbVisibility: true, // Show scrollbar thumb for vertical scrolling
          child: SingleChildScrollView(
            controller: _verticalScrollController, // Attach vertical ScrollController
            child: Scrollbar(
              controller: _horizontalScrollController, // Attach horizontal ScrollController
              thumbVisibility: true, // Show scrollbar thumb for horizontal scrolling
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                controller: _horizontalScrollController, // Attach horizontal ScrollController
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: deviceInfo.screenWidth,
                  ),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.blue),
                    columns:  <DataColumn>[
                      DataColumn(label: Text(S.of(context).customer_name)),
                      DataColumn(label: Text(S.of(context).description)),
                      DataColumn(label: Text(S.of(context).car_details)),
                      DataColumn(label: Text(S.of(context).date)),
                      DataColumn(label: Text(S.of(context).cost)),
                      DataColumn(label: Text(S.of(context).remaining)),
                      DataColumn(label: Text(S.of(context).actions)),
                    ],
                    rows: expensesViewModel.expenses.map<DataRow>((expense) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(expense.customerName ?? 'N/A')),
                          DataCell(Text(expense.description ?? 'N/A')),
                          DataCell(Text(expense.carDetails ?? 'N/A')),
                          DataCell(Text(expense.expensesDate.toString().substring(0, 10))), 
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
        title:  Text(S.of(context).Expenses),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/add_expenses');},
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
            return const CircularProgressIndicator();
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
          title:  Text(S.of(context).edit),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(text: expense.customerName),
                  onChanged: (value) {
                    expense.customerName = value;
                  },
                  decoration:  InputDecoration(labelText: S.of(context).customer_name),
                ),
                TextField(
                  controller: TextEditingController(text: expense.description),
                  onChanged: (value) {
                    expense.description = value;
                  },
                  decoration:  InputDecoration(labelText: S.of(context).description),
                ),
                TextField(
                  controller: TextEditingController(text: expense.carDetails),
                  onChanged: (value) {
                    expense.carDetails = value;
                  },
                  decoration:  InputDecoration(labelText: S.of(context).car_details),
                ),
                TextField(
                  controller: TextEditingController(text: expense.expensesDate.toString()),
                  onChanged: (value) {
                    expense.expensesDate = DateTime.tryParse(value) ?? expense.expensesDate;
                  },
                  decoration:  InputDecoration(labelText: S.of(context).date),
                ),
                TextField(
                  controller: TextEditingController(text: expense.cost?.toString()),
                  onChanged: (value) {
                    expense.cost = value;
                  },
                  decoration:  InputDecoration(labelText:S.of(context).cost) ,
                ),
                TextField(
                  controller: TextEditingController(text: expense.remaining?.toString()),
                  onChanged: (value) {
                    expense.remaining = value;
                  },
                  decoration:  InputDecoration(labelText: S.of(context).remaining),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                viewModel.updateExpense(expense);
                Navigator.of(context).pop();
              },
              child:  Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }
}
