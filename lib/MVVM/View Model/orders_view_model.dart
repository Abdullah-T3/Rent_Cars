import 'dart:convert';
import 'package:bookingcars/MVVM/Models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrdersViewModel extends ChangeNotifier {
  List<OrdersModel> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<OrdersModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final String apiUrl = dotenv.env['apiUrl'] ?? '';
  final String token = dotenv.env['jwt_Secret'] ?? '';

  // Hive Box for storing orders
  late Box<OrdersModel> ordersBox;

  OrdersViewModel() {
    _initializeLocalStorage();
  }

  Future<void> _initializeLocalStorage() async {
    ordersBox = await Hive.openBox<OrdersModel>('ordersBox');
    // Load orders from local storage when initialized
    _orders = ordersBox.values.toList();
    notifyListeners();
  }

  // Fetch orders from API and store them locally
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

        // Store the orders locally in Hive
        await ordersBox.clear();
        for (var order in _orders) {
          await ordersBox.add(order);
        }

        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load orders';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch orders from local storage
  Future<void> fetchLocalOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = ordersBox.values.toList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load local orders: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new order
  Future<void> addOrder(OrdersModel order) async {
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
        await ordersBox.add(order); // Save to local Hive
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

  // Update an order
  Future<void> updateOrder(OrdersModel order) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse("${apiUrl}orders/${order.orderId}"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(order.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _orders.indexWhere((o) => o.orderId == order.orderId);
        if (index != -1) {
          _orders[index] = order;
          ordersBox.putAt(index, order); // Update local Hive data
        }
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to update order';
      }
    } catch (e) {
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
        ordersBox.delete(orderId); // Remove from Hive
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
