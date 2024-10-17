import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/Responsive/enums/DeviceType.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/MVVM/Models/orders_model.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the current locale is Arabic
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    // Create a ScrollController
    final ScrollController _verticalScrollController = ScrollController();
    final ScrollController _horizontalScrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrdersViewModel>(context, listen: false).fetchOrders();
    });

    return Directionality(
      textDirection: isArabic
          ? TextDirection.rtl
          : TextDirection.ltr, // Set direction based on locale
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: Consumer<OrdersViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: Image.asset("assets/images/Progress.gif"));
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            }

            if (viewModel.orders.isEmpty) {
              return const Center(child: Text('No orders available.'));
            }

            return Infowidget(builder: (context, deviceInfo) {
              bool isDesktop = deviceInfo.deviceType == DeviceType.desktop;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      isDesktop ? 50.0 : 10.0, // Add more padding on desktop
                ),
                child: Scrollbar(
                  thumbVisibility: true, // Show scrollbar thumb for vertical scrolling
                  controller: _verticalScrollController,
                  child: SingleChildScrollView(
                    controller: _verticalScrollController,
                    child: Scrollbar(
                      thumbVisibility: true, // Show scrollbar thumb for horizontal scrolling
                      controller: _horizontalScrollController,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _horizontalScrollController,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: deviceInfo.screenWidth, // Ensure horizontal stretching
                          ),
                          child: DataTable(
                            showBottomBorder: true,
                            columns: const <DataColumn>[
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Customer Name')),
                              DataColumn(label: Text('Mobile')),
                              DataColumn(label: Text('Car Name')),
                              DataColumn(label: Text('Car License Plate')),
                              DataColumn(label: Text('Rental Date')),
                              DataColumn(label: Text('Rental Days')),
                              DataColumn(label: Text('Rental Amount')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: viewModel.orders
                                .map(
                                  (order) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(
                                          order.orderId?.toString() ?? '')),
                                      DataCell(Text(order.customerName ?? '')),
                                      DataCell(Text(order.customerMobile ?? '')),
                                      DataCell(Text(order.carName ?? '')),
                                      DataCell(Text(order.carLicensePlate ?? '')),
                                      DataCell(Text(order.rentalDate
                                              ?.toIso8601String()
                                              ?.substring(0, 10) ?? '')),
                                      DataCell(Text(order.rentalDays?.toString() ??
                                          '')),
                                      DataCell(Text(order.rentalAmount?.toString() ??
                                          '')),
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _showEditDialog(context, order);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  // Show a dialog to edit the order
  void _showEditDialog(BuildContext context, OrdersModel order) {
    final viewModel = Provider.of<OrdersViewModel>(context, listen: false);
    final TextEditingController customerNameController =
        TextEditingController(text: order.customerName);
    final TextEditingController customerMobileController =
        TextEditingController(text: order.customerMobile);
    final TextEditingController carNameController =
        TextEditingController(text: order.carName);
    final TextEditingController carLicensePlateController =
        TextEditingController(text: order.carLicensePlate);
    final TextEditingController rentalDaysController =
        TextEditingController(text: order.rentalDays?.toString());
    final TextEditingController rentalAmountController =
        TextEditingController(text: order.rentalAmount?.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Order'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: customerNameController,
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                ),
                TextField(
                  controller: customerMobileController,
                  decoration:
                      const InputDecoration(labelText: 'Customer Mobile'),
                ),
                TextField(
                  controller: carNameController,
                  decoration: const InputDecoration(labelText: 'Car Name'),
                ),
                TextField(
                  controller: carLicensePlateController,
                  decoration:
                      const InputDecoration(labelText: 'Car License Plate'),
                ),
                TextField(
                  controller: rentalDaysController,
                  decoration: const InputDecoration(labelText: 'Rental Days'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: rentalAmountController,
                  decoration:
                      const InputDecoration(labelText: 'Rental Amount'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                // Update order
                final updatedOrder = OrdersModel(
                  orderId: order.orderId,
                  customerName: customerNameController.text,
                  customerMobile: customerMobileController.text,
                  carName: carNameController.text,
                  carLicensePlate: carLicensePlateController.text,
                  rentalDate: order.rentalDate,
                  rentalDays: int.tryParse(rentalDaysController.text),
                  rentalAmount: int.tryParse(rentalAmountController.text),
                  carKmAtRental: order.carKmAtRental,
                );
                await viewModel.updateOrder(updatedOrder);

                if (viewModel.errorMessage != null) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(viewModel.errorMessage!)),
                  );
                } else {
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Order updated successfully.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
