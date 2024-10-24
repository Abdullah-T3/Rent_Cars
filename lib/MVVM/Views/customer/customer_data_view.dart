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
      return SizedBox(
        width: deviceInfo.screenWidth,
        height: deviceInfo.screenHeight,
        child: Scrollbar(
          thumbVisibility: true, // Show scrollbar thumb for vertical scrolling
          controller: verticalScrollController,
          child: SingleChildScrollView(
            controller: verticalScrollController,
            child: Scrollbar(
              thumbVisibility: true, // Show scrollbar thumb for horizontal scrolling
              controller: horizontalScrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: horizontalScrollController,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: deviceInfo.screenWidth,
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(Colors.blue),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Customer Name')),
                      DataColumn(label: Text('ID Number')),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Landline')),
                      DataColumn(label: Text('Reference Line')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: customerViewModel.customers.map<DataRow>((customer) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(customer.customerName ?? 'N/A')),
                          DataCell(Text(customer.idNumber ?? 'N/A')),
                          DataCell(Text(customer.address ?? 'N/A')),
                          DataCell(Text(customer.landline ?? 'N/A')),
                          DataCell(Text(customer.referenceNumber ?? 'N/A')),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(context, customer, customerViewModel);
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
        title: const Text('Customer List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/add_customer');              
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<CustomerViewModel>(
          builder: (context, customerViewModel, child) {
            if (customerViewModel.isLoading) {
              return CircularProgressIndicator();
            }

            return buildTable(customerViewModel);
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, CustomersDataModel customer, CustomerViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Customer'),
          content: SingleChildScrollView( // Allow vertical scrolling in the dialog
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(text: customer.customerName),
                  onChanged: (value) {
                    customer.customerName = value;
                  },
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                ),
                TextField(
                  controller: TextEditingController(text: customer.idNumber),
                  onChanged: (value) {
                    customer.idNumber = value;
                  },
                  decoration: const InputDecoration(labelText: 'ID Number'),
                ),
                TextField(
                  controller: TextEditingController(text: customer.address),
                  onChanged: (value) {
                    customer.address = value;
                  },
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: TextEditingController(text: customer.landline),
                  onChanged: (value) {
                    customer.landline = value;
                  },
                  decoration: const InputDecoration(labelText: 'Landline'),
                ),
                TextField(
                  controller: TextEditingController(text: customer.referenceNumber),
                  onChanged: (value) {
                    customer.referenceNumber = value;
                  },
                  decoration: const InputDecoration(labelText: 'Reference Line'),
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
                viewModel.updateCustomer(customer);
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
