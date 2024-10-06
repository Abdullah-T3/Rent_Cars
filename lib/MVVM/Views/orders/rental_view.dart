import 'package:bookingcars/MVVM/Models/orders_model.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:bookingcars/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersDataView extends StatefulWidget {
  const OrdersDataView({super.key});

  @override
  State<OrdersDataView> createState() => _OrdersDataViewState();
}

class _OrdersDataViewState extends State<OrdersDataView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch data from local cache first
      Provider.of<OrdersViewModel>(context, listen: false).fetchOrders();
    });
  }


  Widget buildTable(OrdersViewModel ordersViewModel) {
    return Infowidget(builder: (context, deviceInfo) {
      return SizedBox(
        width: deviceInfo.screenWidth,
        height: deviceInfo.screenHeight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              // ignore: deprecated_member_use
              dataRowHeight: deviceInfo.localHeight * 0.07,
              headingRowColor:
                  WidgetStateColor.resolveWith((states) => Colors.blue),
              dividerThickness: 2,
              columnSpacing: deviceInfo.localWidth * 0.08,
              columns: <DataColumn>[
                DataColumn(label: Text(S.of(context).customer_name)),

                DataColumn(label: Text(S.of(context).rental_amount)),
                DataColumn(label: Text(S.of(context).plate_number)),
                DataColumn(label: Text(S.of(context).rental_kilometers)),
                DataColumn(label: Text(S.of(context).pickup_date)),
                DataColumn(label: Text(S.of(context).rental_days)),
                DataColumn(label: Text(S.of(context).edit)),
              ],
              rows: ordersViewModel.orders.map<DataRow>((order) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(order.customerName ?? 'N/A'.toString())),
                    DataCell(Text(order.rentalAmount.toString())),
                    DataCell(Text(order.carLicensePlate ?? 'N/A')),
                    DataCell(Text(order.carKmAtRental.toString())),
                    DataCell(
                        Text(order.rentalDate.toString().substring(0, 10))),
                    DataCell(
                        Text(order.rentalDays.toString())),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(context, order, ordersViewModel);
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Bookings List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
          ],
        ),
        drawer: const Mydrawer(),
        body: Center(
          child: Consumer<OrdersViewModel>(
              builder: (context, bookingsViewModel, child) {
            if (bookingsViewModel.isLoading) {
              return Image.asset("assets/images/Progress.gif");
            }
            if (bookingsViewModel.errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Check your internet connection")),
                );
              });
              return bookingsViewModel.orders.isEmpty
                  ? SizedBox(
                      height: deviceInfo.screenHeight * 0.2,
                      width: deviceInfo.screenWidth * 0.2,
                      child: Image.asset("assets/images/no-wifi.png"),
                    )
                  : buildTable(bookingsViewModel);
            }
            return buildTable(bookingsViewModel);
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).pushNamed('/add_order');
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }

void _showAddOrderDialog(BuildContext context) {
  TextEditingController rentalAmountController = TextEditingController();
  TextEditingController carPlateNumberController = TextEditingController();
  TextEditingController pickupDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();

  // Helper function to parse DD-MM-YYYY formatted date
  DateTime parseDate(String dateString) {
    final parts = dateString.split('-');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } else {
      throw const FormatException('Invalid date format');
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add New Rental'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
              ),
              TextField(
                controller: rentalAmountController,
                decoration: const InputDecoration(labelText: 'Rental Amount'),
                keyboardType: TextInputType.number, // Ensure numeric input
              ),
              TextField(
                controller: carPlateNumberController,
                decoration:
                    const InputDecoration(labelText: 'Car Plate Number'),
              ),
              TextField(
                controller: pickupDateController,
                decoration: const InputDecoration(
                    labelText: 'Pickup Date (DD-MM-YYYY)'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: returnDateController,
                decoration: const InputDecoration(
                    labelText: 'Return Date (DD-MM-YYYY)'),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog without adding
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              try {
                // Parse the dates using the custom date parser
                final rentalDate = parseDate(pickupDateController.text);
                final returnDate = parseDate(returnDateController.text);
                final rentalDays = returnDate.difference(rentalDate).inDays;

                final newBooking = OrdersModel(
                  customerName: customerNameController.text,
                  rentalAmount: int.parse(rentalAmountController.text),
                  carLicensePlate: carPlateNumberController.text,
                  rentalDate: rentalDate,
                  rentalDays: rentalDays,
                );

                // Using Future.microtask to avoid calling Provider right away
                Future.microtask(() {
                  if (context.mounted) {
                    Provider.of<OrdersViewModel>(context, listen: false)
                        .addBooking(newBooking)
                        .then((_) {
                      if (context.mounted) {
                        // Optionally refresh the booking list
                        Provider.of<OrdersViewModel>(context, listen: false)
                            .fetchOrders();
                      }
                    }).catchError((error) {
                      // Handle any errors
                      if (context.mounted) {
                        print(error);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add order: $error')),
                        );
                      }
                    });
                  }
                });

                Navigator.of(context).pop(); // Close the dialog after saving
              } catch (error) {
                // Handle invalid input
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter valid dates in DD-MM-YYYY format'),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}



void _showEditDialog(
    BuildContext context, OrdersModel order, OrdersViewModel viewModel) {
  // Format rentalDate using intl package
  final dateFormat = DateFormat('yyyy-MM-dd'); // Adjust the format as needed

  // Controllers for editing the booking data
  TextEditingController customerNameController =
      TextEditingController(text: order.customerName);
  TextEditingController carPlateNumberController =
      TextEditingController(text: order.carLicensePlate);
  TextEditingController rentalDateController = TextEditingController(
      text: order.rentalDate != null ? dateFormat.format(order.rentalDate!) : '');
  TextEditingController rentalDaysController =
      TextEditingController(text: order.rentalDays?.toString() ?? '');
  TextEditingController rentalAmountController =
      TextEditingController(text: order.rentalAmount.toString());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Booking Data'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
              ),
              TextField(
                controller: carPlateNumberController,
                decoration: const InputDecoration(labelText: 'Car Plate Number'),
              ),
              TextField(
                controller: rentalDateController,
                decoration: const InputDecoration(labelText: 'Pickup Date'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: rentalDaysController,
                decoration: const InputDecoration(labelText: 'Return Date'),
                keyboardType: TextInputType.number, // Ensure it's numeric input
              ),
              TextField(
                controller: rentalAmountController,
                decoration: const InputDecoration(labelText: 'Rental Amount'),
                keyboardType: TextInputType.number, // Ensure it's numeric input
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog without saving
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Update the booking data
              order.customerName = customerNameController.text;
              order.carLicensePlate = carPlateNumberController.text;
              order.rentalAmount = int.tryParse(rentalAmountController.text) ?? 0;
              
              // Parse rentalDate from the TextField to DateTime
              order.rentalDate = DateTime.tryParse(rentalDateController.text);
              
              // Parse rentalDays from the TextField to integer
              order.rentalDays = int.tryParse(rentalDaysController.text) ?? 0;

              // Send the updated data to the ViewModel
              viewModel.updateBooking(order.orderId!, order).then((_) {
                viewModel.fetchOrders(); // Refresh the orders list
              }).catchError((error) {
                // Handle any errors if the update fails
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update booking data: $error')),
                );
              });

              Navigator.of(context).pop(); // Close the dialog after saving
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

}
