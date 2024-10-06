import 'package:bookingcars/MVVM/Models/orders_model.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRentalView extends StatefulWidget {
  const AddRentalView({super.key});

  @override
  State<AddRentalView> createState() => _AddRentalViewState();
}

class _AddRentalViewState extends State<AddRentalView> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController rentalAmountController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController rentalKilometersController = TextEditingController();
  TextEditingController pickupDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController carInfoController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();
  Widget buildTextField(String lable, controller) {
    return Infowidget(builder: (context, deviceInfo) {
      return TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $lable';
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(lable),
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Rental"),
        ),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(deviceInfo.screenWidth * 0.05),
                child: Column(
                  children: [
                    buildTextField("Customer Name", customerNameController),
                    SizedBox(height: deviceInfo.screenHeight * 0.01),
                    buildTextField("Customer Phone", customerPhoneController),
                    SizedBox(height: deviceInfo.screenHeight * 0.01),
                    buildTextField("car info", carInfoController),
                    SizedBox(height: deviceInfo.screenHeight * 0.01),
                    buildTextField("Rental Amount", rentalAmountController),
                    SizedBox(height: deviceInfo.screenHeight * 0.01),
                    buildTextField("Plate Number", plateNumberController),
                    SizedBox(height: deviceInfo.screenHeight * 0.01),
                    buildTextField(
                        "Rental Kilometers", rentalKilometersController),
                    SizedBox(height: deviceInfo.screenHeight * 0.01),
                    buildTextField("Pickup", pickupDateController),
                    SizedBox(height: deviceInfo.screenHeight * 0.01),
                    buildTextField("Return", returnDateController),
                    SizedBox(height: deviceInfo.screenHeight * 0.22),
                    Container(
                      padding: EdgeInsets.all(deviceInfo.screenWidth * 0.05),
                      height: deviceInfo.screenHeight * 0.11,
                      width: deviceInfo.screenWidth * 0.9,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onPressed: () {
                          try {
                            // Parse the dates using the custom date parser

                            final rentalDate =
                                parseDate(pickupDateController.text);
                            final returnDate =
                                parseDate(returnDateController.text);
                            final rentalDays =
                                returnDate.difference(rentalDate).inDays;

                            final newRental = OrdersModel(
                              // customer_name,
                              customerName: customerNameController.text.toString(),
                              // customer_mobile,
                              customerMobile: customerPhoneController.text,
                              //car_name,
                              carName: carInfoController.text,
//car_km_at_rental
                              carKmAtRental:
                                  int.parse(rentalKilometersController.text),
                              // rental_amount,

                              rentalAmount:
                                  int.parse(rentalAmountController.text),

                              // car_license_plate
                              carLicensePlate: plateNumberController.text,
                              // rental_days,
                              rentalDate: rentalDate,

                              rentalDays: rentalDays,
                            );
                            // Using Future.microtask to avoid calling Provider right away
                            Future.microtask(() {
                              if (context.mounted) {
                                Provider.of<OrdersViewModel>(context,
                                        listen: false)
                                    .addBooking(newRental)
                                    .then((_) {
                                  if (context.mounted) {
                                    // Optionally refresh the booking list
                                    Provider.of<OrdersViewModel>(context,
                                            listen: false)
                                        .fetchOrders();
                                  }
                                }).catchError((error) {
                                  // Handle any errors
                                  if (context.mounted) {
                                    print(error);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Failed to add order: $error')),
                                    );
                                  }
                                });
                              }
                            });

                            Navigator.of(context)
                                .pop(); // Close the dialog after saving
                          } catch (error) {
                            // Handle invalid input
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please enter valid dates in DD-MM-YYYY format'),
                              ),
                            );
                          }
                        },
                        child: const Text('Save'),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
