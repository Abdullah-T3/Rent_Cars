import 'package:bookingcars/MVVM/Models/orders/orders_model.dart';
import 'package:bookingcars/MVVM/View%20Model/cars_data_view_model.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/MVVM/View%20Model/customer_view_model.dart';
import 'package:bookingcars/MVVM/Views/orders/widgets/build_time_picker.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/Responsive/enums/DeviceType.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:bookingcars/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AddOrderView extends StatefulWidget {
  const AddOrderView({super.key});

  @override
  _AddOrderViewState createState() => _AddOrderViewState();
}

class _AddOrderViewState extends State<AddOrderView> {
  final _formKey = GlobalKey<FormState>();
  final OrdersModel _order = OrdersModel();
  File? _selectedImage;
  bool isDesktop = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _order.imageUrl = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomerViewModel>(context, listen: false).fetchCustomers();
      Provider.of<CarsViewModel>(context, listen: false).fetchCars();
    });
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _order.imageUrl = null;
    });
  }

  void resetOrder() {
    setState(() {
      _order.customerName = '';
      _order.customerMobile = '';
      _order.carLicensePlate = '';
      _order.carName = '';
      _order.rentalDays = 0;
      _order.rentalAmount = 0;
      _order.carKmAtRental = 0;
      _order.rentalDate = DateTime.now();
      _selectedImage = null;
    });
  }

  Future<void> _handleSubmit() async {
    final viewModel = Provider.of<OrderViewModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      try {
        await viewModel.addOrder(_order);
        if (viewModel.errorMessage != null) {
          print(viewModel.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(viewModel.errorMessage!)),
          );
        }

        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _populateFieldsWithCustomerData(String mobileNumber) {
    final customer = Provider.of<CustomerViewModel>(context, listen: false)
        .getCustomerByMobile(mobileNumber);

    setState(() {
      _order.customerName = customer.customerName;
      _order.customerMobile = customer.mobileNumber.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersVM = Provider.of<OrderViewModel>(context);
    return Infowidget(builder: (context, deviceInfo) {
      isDesktop = deviceInfo.deviceType == DeviceType.desktop;
      return Scaffold(
        drawer: const Mydrawer(),
        appBar: AppBar(
          title: Text(S.of(context).add_order),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Customer Name Input
                  TextFormField(
                    controller: TextEditingController(text: _order.customerName),
                    decoration: InputDecoration(
                      labelText: S.of(context).customer_name,
                    ),
                    onSaved: (value) => _order.customerName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).please_enter_customer_name;
                      }
                      return null;
                    },
                  ),

                  // Customer Mobile Input with Autocomplete
                  Consumer<CustomerViewModel>(builder: (context, customerVM, child) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        final matchingCustomers = customerVM
                            .searchCustomersByMobile(textEditingValue.text)
                            .map((customer) => customer.mobileNumber?.toString() ?? '')
                            .where((mobile) => mobile.isNotEmpty);
                        return matchingCustomers;
                      },
                      onSelected: (String selection) {
                        _order.customerMobile = selection;

                        final customer = customerVM.getCustomerByMobile(selection);
                        setState(() {
                          _order.customerName = customer.customerName;
                        });
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: S.of(context).customer_mobile,
                          ),
                          onSaved: (value) => _order.customerMobile = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_customer_mobile;
                            }
                            return null;
                          },
                        );
                      },
                    );
                  }),

                  // Car License Plate Input with Autocomplete
                  Consumer<CarsViewModel>(builder: (context, carsVM, child) {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        final matchingCars = carsVM
                            .searchCarsByLicensePlate(textEditingValue.text)
                            .map((car) => car.license_plate.toString())
                            .where((plate) => plate.isNotEmpty);
                        return matchingCars;
                      },
                      onSelected: (String selection) {
                        _order.carLicensePlate = selection;

                        // Fetch the car details using the selected license plate
                        final car = carsVM.getCarByLicensePlate(selection);
                        setState(() {
                          _order.carName = '${car.brand} ${car.model}'; // Update car name with brand and model
                        });
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: S.of(context).car_license_plate,
                          ),
                          onSaved: (value) => _order.carLicensePlate = value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_car_license_plate;
                            }
                            return null;
                          },
                        );
                      },
                    );
                  }),

                  // Car Name Input
                  TextFormField(
                    controller: TextEditingController(text: _order.carName),
                    decoration: InputDecoration(
                      labelText: S.of(context).car_name,
                    ),
                    onSaved: (value) => _order.carName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).please_enter_car_name;
                      }
                      return null;
                    },
                  ),

                  // Rental Days Input
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).rental_days,
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _order.rentalDays = int.tryParse(value ?? ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).please_enter_rental_days;
                      }
                      return null;
                    },
                  ),

                  // Rental Amount Input
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).rental_amount,
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _order.rentalAmount = int.tryParse(value ?? ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).please_enter_rental_amount;
                      }
                      return null;
                    },
                  ),

                  // Rental Kilometers Input
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).rental_kilometers,
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _order.carKmAtRental = int.tryParse(value ?? ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).please_enter_rental_kilometers;
                      }
                      return null;
                    },
                  ),

                  // Rental Date Picker
                       BuildTimePicker(
                    onDateSelected: (selectedDate) {
                      setState(() {
                        _order.rentalDate =
                            selectedDate; // Update the rental date in the order model
                      });
                    },
                  ),


                  // Image Picker
                  _selectedImage != null
                      ? Column(
                          children: [
                            Image.file(_selectedImage!),
                            ElevatedButton(
                              onPressed: _removeImage,
                              child: Text(S.of(context).remove_image),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          child: Text(S.of(context).add_image),
                        ),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    child: Text(S.of(context).add_order),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
