import 'package:bookingcars/MVVM/Models/customers/CustomersDataModel.dart';
import 'package:bookingcars/MVVM/View%20Model/customer_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDataView extends StatefulWidget {
  const CustomerDataView({super.key});

  @override
  State<CustomerDataView> createState() => _CustomerDataViewState();
}

class _CustomerDataViewState extends State<CustomerDataView> {
  // Create scroll controllers for vertical and horizontal scrolling
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomerViewModel>(context, listen: false).fetchCustomers();
    });
  }

  Widget buildTable(CustomerViewModel customerViewModel) {
    return Infowidget(builder: (context, deviceInfo) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: deviceInfo.screenWidth,
              height: deviceInfo.screenHeight * 0.8,
              child: Scrollbar(
                thumbVisibility:
                    true, // Show scrollbar thumb for vertical scrolling
                controller: verticalScrollController,
                child: SingleChildScrollView(
                  controller: verticalScrollController,
                  child: Scrollbar(
                    thumbVisibility:
                        true, // Show scrollbar thumb for horizontal scrolling
                    controller: horizontalScrollController,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: horizontalScrollController,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: deviceInfo.screenWidth - 64,
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
                            columns: const <DataColumn>[
                              DataColumn(label: Text('Customer Name')),
                              DataColumn(label: Text('ID Number')),
                              DataColumn(label: Text('Address')),
                              DataColumn(label: Text('Landline')),
                              DataColumn(label: Text('Reference Line')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: customerViewModel.customers
                                .map<DataRow>((customer) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                      Text(customer.customerName ?? 'N/A')),
                                  DataCell(Text(customer.idNumber ?? 'N/A')),
                                  DataCell(Text(customer.address ?? 'N/A')),
                                  DataCell(Text(customer.landline ?? 'N/A')),
                                  DataCell(
                                      Text(customer.referenceNumber ?? 'N/A')),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          child: IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            tooltip: 'Edit Customer',
                                            onPressed: () {
                                              _showEditDialog(context, customer,
                                                  customerViewModel);
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
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Customers',
            onPressed: () {
              // Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search feature coming soon')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Customer',
            onPressed: () {
              Navigator.of(context).pushNamed('/add_customer');
            },
          ),
        ],
      ),
      body: Consumer<CustomerViewModel>(
        builder: (context, customerViewModel, child) {
          if (customerViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (customerViewModel.customers.isEmpty) {
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
                        const Icon(Icons.person_outline,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'No Customers Found',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Add a new customer to get started',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Customer'),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/add_customer');
                          },
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

          return buildTable(customerViewModel);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CustomerViewModel>(context, listen: false)
              .fetchCustomers();
        },
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _showEditDialog(BuildContext context, CustomersDataModel customer,
      CustomerViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Customer'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            // Allow vertical scrolling in the dialog
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                TextField(
                  controller:
                      TextEditingController(text: customer.customerName),
                  onChanged: (value) {
                    customer.customerName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(text: customer.idNumber),
                  onChanged: (value) {
                    customer.idNumber = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'ID Number',
                    prefixIcon: Icon(Icons.badge, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(text: customer.address),
                  onChanged: (value) {
                    customer.address = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.home, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(text: customer.landline),
                  onChanged: (value) {
                    customer.landline = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Landline',
                    prefixIcon: Icon(Icons.phone, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller:
                      TextEditingController(text: customer.referenceNumber),
                  onChanged: (value) {
                    customer.referenceNumber = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Reference Line',
                    prefixIcon: Icon(Icons.contact_phone, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.updateCustomer(customer);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
}
