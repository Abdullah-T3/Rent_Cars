import 'package:bookingcars/MVVM/Models/expenses/expenses_data_model.dart';
import 'package:bookingcars/MVVM/View%20Model/expenses_data_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/Responsive/enums/DeviceType.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Add ExpensesSearchDelegate class definition
class ExpensesSearchDelegate extends SearchDelegate<String> {
  final ExpensesViewModel viewModel;

  ExpensesSearchDelegate(this.viewModel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text(S.of(context).search));
    }

    final results = viewModel.expenses.where((expense) {
      final customerNameMatch =
          expense.customerName?.toLowerCase().contains(query.toLowerCase()) ??
              false;
      final descriptionMatch =
          expense.description?.toLowerCase().contains(query.toLowerCase()) ??
              false;
      final carDetailsMatch =
          expense.carDetails?.toLowerCase().contains(query.toLowerCase()) ??
              false;
      return customerNameMatch || descriptionMatch || carDetailsMatch;
    }).toList();

    if (results.isEmpty) {
      return Center(child: Text(S.of(context).no_results_found));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final expense = results[index];
        return ListTile(
          title: Text(expense.customerName ?? 'N/A'),
          subtitle: Text(expense.description ?? 'N/A'),
          trailing: Text('${expense.cost}'),
          onTap: () {
            close(context, expense.expensesId.toString());
          },
        );
      },
    );
  }
}

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
      bool isDesktop = deviceInfo.deviceType == DeviceType.desktop;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 50.0 : 10.0, // Add more padding on desktop
        ),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Scrollbar(
              thumbVisibility:
                  true, // Show scrollbar thumb for vertical scrolling
              controller: _verticalScrollController,
              child: SingleChildScrollView(
                controller: _verticalScrollController,
                child: Scrollbar(
                  thumbVisibility:
                      true, // Show scrollbar thumb for horizontal scrolling
                  controller: _horizontalScrollController,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _horizontalScrollController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: deviceInfo
                            .screenWidth, // Ensure horizontal stretching
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.grey.withOpacity(0.3),
                          dataTableTheme: DataTableThemeData(
                            headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            dataTextStyle: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        child: DataTable(
                          headingRowColor:
                              MaterialStateProperty.all(Colors.blue),
                          showBottomBorder: true,
                          headingRowHeight: 50,
                          dataRowHeight: 65,
                          horizontalMargin: 16,
                          columnSpacing: 24,
                          showCheckboxColumn: false,
                          dividerThickness: 1,
                          columns: <DataColumn>[
                            DataColumn(
                                label: Text(S.of(context).customer_name)),
                            DataColumn(label: Text(S.of(context).description)),
                            DataColumn(label: Text(S.of(context).car_details)),
                            DataColumn(label: Text(S.of(context).date)),
                            DataColumn(label: Text(S.of(context).cost)),
                            DataColumn(label: Text(S.of(context).remaining)),
                            DataColumn(label: Text(S.of(context).actions)),
                          ],
                          rows: expensesViewModel.expenses
                              .map<DataRow>((expense) {
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text(expense.customerName ?? 'N/A')),
                                DataCell(Text(expense.description ?? 'N/A')),
                                DataCell(Text(expense.carDetails ?? 'N/A')),
                                DataCell(Text(expense.expensesDate
                                    .toString()
                                    .substring(0, 10))),
                                DataCell(
                                    Text(expense.cost?.toString() ?? 'N/A')),
                                DataCell(Text(
                                    expense.remaining?.toString() ?? 'N/A')),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          tooltip: 'Edit Expense',
                                          onPressed: () {
                                            _showEditDialog(context, expense,
                                                expensesViewModel);
                                          },
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          tooltip: 'Delete Expense',
                                          onPressed: () {
                                            _showDeleteConfirmationDialog(
                                                context,
                                                expense,
                                                expensesViewModel);
                                          },
                                        ),
                                      ),
                                    ],
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
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the current locale is Arabic
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic
          ? TextDirection.rtl
          : TextDirection.ltr, // Set direction based on locale
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).Expenses,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, size: 28),
              onPressed: () {
                Navigator.of(context).pushNamed('/add_expenses');
              },
              tooltip: 'Add New Expense',
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ExpensesSearchDelegate(
                      Provider.of<ExpensesViewModel>(context, listen: false)),
                );
              },
              icon: const Icon(Icons.search),
              tooltip: 'Search Expenses',
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
              icon: const Icon(Icons.home),
              tooltip: 'Go to Home',
            ),
          ],
        ),
        body: Consumer<ExpensesViewModel>(
          builder: (context, expensesViewModel, child) {
            if (expensesViewModel.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Progress.gif", height: 100),
                    const SizedBox(height: 16),
                    const Text('Loading expenses...',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }

            if (expensesViewModel.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 60, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(expensesViewModel.errorMessage!,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => expensesViewModel.fetchExpenses(),
                      child: Text(S.of(context).retry),
                    ),
                  ],
                ),
              );
            }

            if (expensesViewModel.expenses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.account_balance_wallet_outlined,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            S.of(context).no_expenses_found,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            S.of(context).create,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/add_expenses');
                            },
                            icon: const Icon(Icons.add),
                            label: Text(S.of(context).add_expenses),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return buildTable(expensesViewModel);
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, ExpensesDataModel expense,
      ExpensesViewModel viewModel) {
    final TextEditingController customerNameController =
        TextEditingController(text: expense.customerName);
    final TextEditingController descriptionController =
        TextEditingController(text: expense.description);
    final TextEditingController carDetailsController =
        TextEditingController(text: expense.carDetails);
    final TextEditingController costController =
        TextEditingController(text: expense.cost?.toString());
    final TextEditingController remainingController =
        TextEditingController(text: expense.remaining?.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            S.of(context).edit,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: customerNameController,
                  decoration: InputDecoration(
                    labelText: S.of(context).customer_name,
                    prefixIcon: const Icon(Icons.person, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: S.of(context).description,
                    prefixIcon:
                        const Icon(Icons.description, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: carDetailsController,
                  decoration: InputDecoration(
                    labelText: S.of(context).car_details,
                    prefixIcon:
                        const Icon(Icons.directions_car, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: costController,
                  decoration: InputDecoration(
                    labelText: S.of(context).cost,
                    prefixIcon:
                        const Icon(Icons.attach_money, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: remainingController,
                  decoration: InputDecoration(
                    labelText: S.of(context).remaining,
                    prefixIcon: const Icon(Icons.account_balance_wallet,
                        color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).cancel,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedExpense = ExpensesDataModel(
                  expensesId: expense.expensesId,
                  customerName: customerNameController.text,
                  description: descriptionController.text,
                  carDetails: carDetailsController.text,
                  expensesDate: expense.expensesDate,
                  cost: costController.text,
                  remaining: remainingController.text,
                );

                viewModel.updateExpense(updatedExpense);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: Text(
                S.of(context).save,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context,
      ExpensesDataModel expense, ExpensesViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            S.of(context).confirm_delete,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).confirm_delete,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).cancel,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.deleteExpense(expense.expensesId!);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: Text(
                S.of(context).delete,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        );
      },
    );
  }
}
