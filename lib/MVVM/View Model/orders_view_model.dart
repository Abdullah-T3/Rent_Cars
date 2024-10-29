import 'dart:convert';
import 'dart:io';
import 'package:bookingcars/MVVM/Models/orders/orders_model.dart';
import 'package:bookingcars/MVVM/Models/orders/upadte_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OrdersViewModel extends ChangeNotifier {
  List<OrdersModel> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;


  List<OrdersModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  final String apiUrl = dotenv.env['apiUrl'] ?? '';
  final String token = dotenv.env['jwt_Secret'] ?? '';
  // Base URL of your API

  // Fetch all orders
  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("${apiUrl}orders"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _orders = jsonData.map((item) => OrdersModel.fromJson(item)).toList();
        _errorMessage = null;
      } else {
        print(response.body);
        _errorMessage = 'Failed to load orders';
      }
    } catch (e) {
      print(e);
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new order
Future<void> addOrder(OrdersModel order, {File? imageFile}) async {
    _isLoading = true;
    notifyListeners();

    try {

      

      final response = await http.post(
        Uri.parse("${apiUrl}orders"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(order.toJson()),
      );

      if (response.statusCode == 201) {
        _orders.add(order);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to add order';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update an existing order

  Future<void> updateOrder(OrdersModel order) async {
    _isLoading = true;
    notifyListeners();
    final updatedOrder =UpdateOrdersModel (
      customerName: order.customerName,
      customerMobile: order.customerMobile,
      carName: order.carName,
      carLicensePlate: order.carLicensePlate,
      rentalDays: order.rentalDays,
      rentalAmount: order.rentalAmount,
      carKmAtRental: order.carKmAtRental,
      rentalDate: order.rentalDate,
    );

    try {
      final response = await http.put(
        Uri.parse('${apiUrl}orders/${order.orderId}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body:updateOrdersModelToJson(updatedOrder),
      );

      if (response.statusCode == 200) {
        final index = _orders.indexWhere((o) => o.orderId == order.orderId);
        if (index != -1) {
          _orders[index] = order;
        }
        _errorMessage = null;
      } else {
        print(response.body);
        _errorMessage = 'Failed to update order';
      }
    } catch (e) {
      print(e);
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete an order
  Future<void> deleteOrder(int orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('${apiUrl}orders/$orderId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _orders.removeWhere((order) => order.orderId == orderId);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to delete order';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
