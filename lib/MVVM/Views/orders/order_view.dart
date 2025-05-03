import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/Responsive/enums/DeviceType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/MVVM/Models/orders/orders_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the current locale is Arabic
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    // Create a ScrollController
    final ScrollController verticalScrollController = ScrollController();
    final ScrollController horizontalScrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderViewModel>(context, listen: false).fetchOrders();
    });

    return Directionality(
      textDirection: isArabic
          ? TextDirection.rtl
          : TextDirection.ltr, // Set direction based on locale
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders',
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, size: 28),
              onPressed: () {
                Navigator.of(context).pushNamed('/add_order');
              },
              tooltip: 'Add New Order',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Consumer<OrderViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Progress.gif", height: 100),
                    const SizedBox(height: 16),
                    const Text('Loading orders...',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }

            if (viewModel.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 60, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(viewModel.errorMessage!,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => viewModel.fetchOrders(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (viewModel.orders.isEmpty) {
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
                          const Icon(Icons.assignment_outlined,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            'No Orders Found',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Create your first order by clicking the + button',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/add_order');
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Add New Order'),
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

            return Infowidget(builder: (context, deviceInfo) {
              bool isDesktop = deviceInfo.deviceType == DeviceType.desktop;

              return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        isDesktop ? 50.0 : 10.0, // Add more padding on desktop
                  ),
                  child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                      minWidth: deviceInfo
                                          .screenWidth, // Ensure horizontal stretching
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor:
                                            Colors.grey.withOpacity(0.3),
                                        dataTableTheme: DataTableThemeData(
                                          headingTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                          ),
                                          dataTextStyle: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      child: DataTable(
                                        headingRowColor:
                                            WidgetStateProperty.all(
                                                Colors.blue),
                                        showBottomBorder: true,
                                        headingRowHeight: 50,
                                        dataRowHeight: 65,
                                        horizontalMargin: 16,
                                        columnSpacing: 24,
                                        showCheckboxColumn: false,
                                        dividerThickness: 1,
                                        columns: const <DataColumn>[
                                          DataColumn(label: Text('ID')),
                                          DataColumn(
                                              label: Text('Customer Name')),
                                          DataColumn(label: Text('Mobile')),
                                          DataColumn(label: Text('Car Name')),
                                          DataColumn(
                                              label: Text('Car License Plate')),
                                          DataColumn(
                                              label: Text('Rental Date')),
                                          DataColumn(
                                              label: Text('Rental Days')),
                                          DataColumn(
                                              label: Text('Rental Amount')),
                                          DataColumn(label: Text('Image')),
                                          DataColumn(label: Text('Actions')),
                                        ],
                                        rows: viewModel.orders
                                            .map(
                                              (order) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell(Text(order.orderId
                                                          ?.toString() ??
                                                      '')),
                                                  DataCell(Text(
                                                      order.customerName ??
                                                          '')),
                                                  DataCell(Text(
                                                      order.customerMobile ??
                                                          '')),
                                                  DataCell(Text(
                                                      order.carName ?? '')),
                                                  DataCell(Text(
                                                      order.carLicensePlate ??
                                                          '')),
                                                  DataCell(Text(order.rentalDate
                                                          ?.toIso8601String()
                                                          .substring(0, 10) ??
                                                      '')),
                                                  DataCell(Text(order.rentalDays
                                                          ?.toString() ??
                                                      '')),
                                                  DataCell(Text(order
                                                          .rentalAmount
                                                          ?.toString() ??
                                                      '')),
                                                  DataCell(
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.05),
                                                            blurRadius: 4,
                                                            spreadRadius: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      child: order.imageUrl !=
                                                                  null &&
                                                              order.imageUrl!
                                                                  .isNotEmpty
                                                          ? Image.network(
                                                              order.imageUrl!,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .broken_image_outlined,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 28,
                                                                  ),
                                                                );
                                                              },
                                                              loadingBuilder:
                                                                  (context,
                                                                      child,
                                                                      loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    value: loadingProgress.expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                                            loadingProgress.expectedTotalBytes!
                                                                        : null,
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                          : const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .image_not_supported,
                                                                color:
                                                                    Colors.grey,
                                                                size: 28,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  DataCell(Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.blue),
                                                          tooltip: 'Edit Order',
                                                          onPressed: () {
                                                            _showEditDialog(
                                                                context, order);
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.red),
                                                          tooltip:
                                                              'Delete Order',
                                                          onPressed: () {
                                                            _showDeleteConfirmationDialog(
                                                                context,
                                                                order.orderId!,
                                                                viewModel);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )),
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
                          ))));
            });
          },
        ),
      ),
    );
  }

  // Show a dialog to edit the order
  void _showEditDialog(BuildContext context, OrdersModel order) {
    final viewModel = Provider.of<OrderViewModel>(context, listen: false);
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
    final TextEditingController imageUrlController =
        TextEditingController(text: order.imageUrl);

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
                SizedBox(height: 10),
                TextField(
                  controller: customerMobileController,
                  decoration:
                      const InputDecoration(labelText: 'Customer Mobile'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: carNameController,
                  decoration: const InputDecoration(labelText: 'Car Name'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: carLicensePlateController,
                  decoration:
                      const InputDecoration(labelText: 'Car License Plate'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: rentalDaysController,
                  decoration: const InputDecoration(labelText: 'Rental Days'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: rentalAmountController,
                  decoration: const InputDecoration(labelText: 'Rental Amount'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: imageUrlController,
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          // Ensure the path starts with a forward slash for Cloudinary upload
                          String path = image.path;
                          if (!path.startsWith('/')) {
                            // On Windows, convert backslashes to forward slashes
                            path = path.replaceAll('\\', '/');
                            // Ensure it starts with a slash
                            if (!path.startsWith('/')) {
                              path = '/$path';
                            }
                          }
                          imageUrlController.text = path;
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: imageUrlController.text.isNotEmpty
                      ? imageUrlController.text.startsWith('/')
                          ? Image.file(
                              File(imageUrlController.text),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Icon(Icons.image_not_supported));
                              },
                            )
                          : Image.network(
                              imageUrlController.text,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Icon(Icons.image_not_supported));
                              },
                            )
                      : const Center(child: Icon(Icons.image)),
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
                  imageUrl: imageUrlController.text,
                  createdAt: order.createdAt,
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

  void _showDeleteConfirmationDialog(
      BuildContext context, int orderId, OrderViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Confirm Delete',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Are you sure you want to delete this order?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'This action cannot be undone.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child:
                  const Text('Delete', style: TextStyle(color: Colors.white)),
              onPressed: () {
                viewModel.deleteOrder(orderId);
                Navigator.of(context).pop();
              },
            ),
          ],
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          buttonPadding: const EdgeInsets.symmetric(horizontal: 8),
        );
      },
    );
  }
}
