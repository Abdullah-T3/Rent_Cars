import 'package:bookingcars/MVVM/Models/customers/CustomersDataModel.dart';
import 'package:bookingcars/MVVM/View%20Model/customer_view_model.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCustomerView extends StatefulWidget {
  const AddCustomerView({super.key});

  @override
  _AddCustomerViewState createState() => _AddCustomerViewState();
}

class _AddCustomerViewState extends State<AddCustomerView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landlineController = TextEditingController();
  final TextEditingController _referenceNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final customersViewModel = Provider.of<CustomerViewModel>(context);

    return Infowidget(
      builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Customer'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Customer Name Field
                TextFormField(
                  controller: _customerNameController,
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the customer name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
      
                // ID Number Field
                TextFormField(
                  controller: _idNumberController,
                  decoration: const InputDecoration(labelText: 'ID Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
      
                // Address Field
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
      
                // Landline Field
                TextFormField(
                  controller: _landlineController,
                  decoration: const InputDecoration(labelText: 'Landline'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the landline number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
      
                // Reference Number Field
                TextFormField(
                  controller: _referenceNumberController,
                  decoration: const InputDecoration(labelText: 'Reference Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the reference number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
      
                // Submit Button
                Container(
                  width: deviceInfo.screenWidth * 0.5,
                  height: deviceInfo.screenHeight * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Create a new customer object
                        final newCustomer = CustomersDataModel(
                          customerName: _customerNameController.text,
                          idNumber: _idNumberController.text,
                          address: _addressController.text,
                          landline: _landlineController.text,
                          referenceNumber: _referenceNumberController.text,
                        );
                  
                        // Call the ViewModel to add the customer
                        await customersViewModel.addCustomer(newCustomer);
                  
                        // Navigate back or show a success message
                        if (customersViewModel.errorMessage == null || customersViewModel.errorMessage!.isEmpty) {
                          Navigator.pop(context); // Go back to previous screen
                        } else {
                          // Show error message if there's an issue
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(customersViewModel.errorMessage!)));
                        }
                      }
                    },
                    child: const Text('Add Customer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );  
      }
      
    );
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _idNumberController.dispose();
    _addressController.dispose();
    _landlineController.dispose();
    _referenceNumberController.dispose();
    super.dispose();
  }
}
