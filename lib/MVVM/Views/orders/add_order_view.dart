import 'package:bookingcars/MVVM/Models/orders_model.dart';
import 'package:bookingcars/MVVM/View%20Model/orders_view_model.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:bookingcars/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AddOrderView extends StatefulWidget {
  const AddOrderView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddOrderViewState createState() => _AddOrderViewState();
}

class _AddOrderViewState extends State<AddOrderView> {
  final _formKey = GlobalKey<FormState>();
  final OrdersModel _order = OrdersModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Mydrawer(),
      appBar: AppBar(
        title: const Text('Add Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).customer_name),
                onSaved: (value) => _order.customerName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter customer name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).customer_mobile),
                onSaved: (value) => _order.customerMobile = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter customer mobile';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).car_license_plate),
                onSaved: (value) => _order.carLicensePlate = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car license plate';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).car_name),
                onSaved: (value) => _order.carName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).rental_days),
                keyboardType: TextInputType.number,
                onSaved: (value) => _order.rentalDays = int.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rental days';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).rental_amount),
                keyboardType: TextInputType.number,
                onSaved: (value) => _order.rentalAmount = int.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rental amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).rental_kilometers),
                keyboardType: TextInputType.number,
                onSaved: (value) => _order.carKmAtRental = int.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rental kilometers';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(labelText: S.of(context).rental_date),
                keyboardType: TextInputType.datetime,
                onSaved: (value) => _order.rentalDate = DateTime.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rental date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Provider.of<OrdersViewModel>(context, listen: false).addOrder(_order);
                    Navigator.pop(context); // Close the form after submission
                  }
                },
                child:  Text(S.of(context).add_order),
              ),
            ],
          ),
        ),
      ),
    );
  }
}