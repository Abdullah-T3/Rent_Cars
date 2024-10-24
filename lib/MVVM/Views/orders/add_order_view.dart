import 'dart:io';

import 'package:bookingcars/MVVM/Models/orders/orders_model.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/Responsive/enums/DeviceType.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:bookingcars/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  // Function to pick an image from the gallery or take a photo
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _order.imagePath =
            pickedFile.path; // Assuming OrdersModel has a field for image path
      });
    }
  }

  // Function to remove the selected image
  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _order.imagePath =
          null; // Assuming OrdersModel has a field for image path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Infowidget(builder: (context, deviceInfo) {
      isDesktop = deviceInfo.deviceType == DeviceType.desktop;
      return Scaffold(
        drawer: const Mydrawer(),
        appBar: AppBar(
          title: const Text('Add Order'),
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
                    decoration:
                        InputDecoration(labelText: S.of(context).customer_name),
                    onSaved: (value) => _order.customerName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter customer name';
                      }
                      return null;
                    },
                  ),
                  // Customer Mobile Input
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: S.of(context).customer_mobile),
                    onSaved: (value) => _order.customerMobile = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter customer mobile';
                      }
                      return null;
                    },
                  ),
                  // Car License Plate Input
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: S.of(context).car_license_plate),
                    onSaved: (value) => _order.carLicensePlate = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter car license plate';
                      }
                      return null;
                    },
                  ),
                  // Car Name Input
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).car_name),
                    onSaved: (value) => _order.carName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter car name';
                      }
                      return null;
                    },
                  ),
                  // Rental Days Input
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).rental_days),
                    keyboardType: TextInputType.number,
                    onSaved: (value) =>
                        _order.rentalDays = int.tryParse(value ?? ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter rental days';
                      }
                      return null;
                    },
                  ),
                  // Rental Amount Input
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).rental_amount),
                    keyboardType: TextInputType.number,
                    onSaved: (value) =>
                        _order.rentalAmount = int.tryParse(value ?? ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter rental amount';
                      }
                      return null;
                    },
                  ),
                  // Rental Kilometers Input
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: S.of(context).rental_kilometers),
                    keyboardType: TextInputType.number,
                    onSaved: (value) =>
                        _order.carKmAtRental = int.tryParse(value ?? ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter rental kilometers';
                      }
                      return null;
                    },
                  ),
                  // Rental Date Input
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).rental_date),
                    keyboardType: TextInputType.datetime,
                    onSaved: (value) =>
                        _order.rentalDate = DateTime.tryParse(value ?? ''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter rental date';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Image Picker Section
                  _selectedImage != null
                      ? Column(
                          children: [
                            Image.file(
                              _selectedImage!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: _removeImage,
                              icon: const Icon(Icons.delete),
                              label: Text(
                                'Remove Photo',
                                style: isDesktop
                                    ? TextStyle(
                                        fontSize:
                                            deviceInfo.screenWidth / 2 * 0.025)
                                    : TextStyle(
                                        fontSize:
                                            deviceInfo.screenWidth * 0.025),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 150,
                          width: 150,
                          child: Icon(Icons.camera_alt, size: 100),
                        ),
                  isDesktop
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _pickImage(ImageSource.camera),
                              icon: const Icon(Icons.camera),
                              label: Text(
                                'Take Photo',
                                style: isDesktop
                                    ? TextStyle(
                                        fontSize:
                                            deviceInfo.screenWidth / 2 * 0.025)
                                    : TextStyle(
                                        fontSize:
                                            deviceInfo.screenWidth * 0.025),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.photo),
                              label: Text(
                                'Choose from Gallery',
                                style: isDesktop
                                    ? TextStyle(
                                        fontSize:
                                            deviceInfo.screenWidth / 2 * 0.025)
                                    : TextStyle(
                                        fontSize:
                                            deviceInfo.screenWidth * 0.025),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      : ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.photo),
                          label: Text(
                            'Choose from Gallery',
                            style: isDesktop
                                ? TextStyle(
                                    fontSize:
                                        deviceInfo.screenWidth / 2 * 0.025)
                                : TextStyle(
                                    fontSize: deviceInfo.screenWidth * 0.025),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                  const SizedBox(height: 20),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Provider.of<OrdersViewModel>(context, listen: false)
                            .addOrder(_order);
                        Navigator.pop(
                            context); // Close the form after submission
                      }
                    },
                    child: Text(
                      S.of(context).add_order,
                      style: isDesktop
                          ? TextStyle(
                              fontSize: deviceInfo.screenWidth / 2 * 0.025)
                          : TextStyle(fontSize: deviceInfo.screenWidth * 0.025),
                      overflow: TextOverflow.ellipsis,
                    ),
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
