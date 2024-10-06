import 'package:flutter/material.dart';
import 'package:bookingcars/MVVM/Models/orders_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

class OrdersViewModel extends ChangeNotifier {
  final String _baseUrl = dotenv.env['apiUrl']!; // Load from env
  final String _token =
      dotenv.env['jwt_Secret']!; // Bearer token for authentication
  List<OrdersModel> _orders = [];

  List<OrdersModel> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners about loading state

    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}orders'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _orders = ordersModelFromJson(response.body);
        notifyListeners(); // Notify listeners about state changes
      } else {
        _orders = [];
        throw Exception(response.body);
      }
    } catch (e) {
      _errorMessage = e.toString(); // Set error message
    } finally {
      _isLoading = false; // End loading state
      notifyListeners(); // Notify listeners about state changes
    }
  }

  Future<void> addBooking(OrdersModel order) async {
    _isLoading = true;
    _errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners about loading state

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      var request = http.Request('POST', Uri.parse('${_baseUrl}orders'));
      request.body = ordersModelToJson([order]);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        print(await response.stream.bytesToString());
      } else {
        print(response.statusCode);
        print("=============================");
      }
    } catch (e) {
      print("------------------------------"+e.toString());
      _errorMessage = e.toString(); // Set error message
    } finally {
      _isLoading = false; // End loading state
      notifyListeners(); // Notify listeners about state changes
    }
  }

  Future<void> updateBooking(int id, OrdersModel order) async {
    _isLoading = true;
    _errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners about loading state

    try {
      final response = await http.put(
        Uri.parse('${_baseUrl}orders/$id'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        body: ordersModelToJson([order]),
      );

      if (response.statusCode == 200) {
        await fetchOrders(); // Refresh bookings after updating
      } else {
        throw Exception('Failed to update booking');
      }
    } catch (e) {
      _errorMessage = e.toString(); // Set error message
    } finally {
      _isLoading = false; // End loading state
      notifyListeners(); // Notify listeners about state changes
    }
  }

  Future<void> deleteBooking(int id) async {
    _isLoading = true;
    _errorMessage = null; // Reset error message
    notifyListeners(); // Notify listeners about loading state

    try {
      final response = await http.delete(
        Uri.parse('${_baseUrl}orders/$id'),
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        await fetchOrders(); // Refresh bookings after deleting
      } else {
        throw Exception('Failed to delete booking');
      }
    } catch (e) {
      _errorMessage = e.toString(); // Set error message
    } finally {
      _isLoading = false; // End loading state
      notifyListeners(); // Notify listeners about state changes
    }
  }
}
