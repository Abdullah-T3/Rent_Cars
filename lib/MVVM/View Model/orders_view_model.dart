import 'package:bookingcars/MVVM/Models/orders/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderViewModel extends ChangeNotifier {
  List<OrdersModel> _orders = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<OrdersModel> get orders => _orders;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  final String _baseUrl = '${dotenv.env['apiUrl']}orders';
  Box<OrdersModel>? _ordersBox;

  OrderViewModel() {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(OrdersModelAdapter().typeId)) {
      Hive.registerAdapter(OrdersModelAdapter());
    }
    _ordersBox = await Hive.openBox<OrdersModel>('ordersBox');
    _orders = _ordersBox?.values.toList() ?? [];
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    _setLoading(true);
    try {
      var request = http.Request('GET', Uri.parse(_baseUrl));
      request.headers.addAll(_headers());

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var strings = await response.stream.bytesToString();
        List jsonData = json.decode(strings);

        _orders = jsonData
            .map<OrdersModel>((json) => OrdersModel.fromJson(json))
            .toList();

        // Cache the fetched data
        await _ordersBox?.clear();
        for (var order in _orders) {
          await _ordersBox?.add(order);
        }

        _errorMessage = null;
      } else {
        _handleError(response as http.Response);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addOrder(OrdersModel order) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers(),
        body: ordersModelToJson([order]), // Ensure this is the right method for converting the model to JSON
      );
      if (response.statusCode == 201) {
        _orders.add(order);
        await _ordersBox?.add(order);
        _errorMessage = null;
      } else {
        _handleError(response);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> updateOrder(OrdersModel order) async {
    _setLoading(true);
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${order.orderId}'),
        headers: _headers(),
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _orders.indexWhere((o) => o.orderId == order.orderId);
        if (index != -1) {
          _orders[index] = order;
          await _ordersBox?.putAt(index, order);
        }
      } else {
        _handleError(response);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> deleteOrder(int orderId) async {
    _setLoading(true);
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$orderId'),
        headers: _headers(),
      );
      if (response.statusCode == 200) {
        _orders.removeWhere((order) => order.orderId == orderId);
        await _ordersBox?.deleteAt(_orders.indexWhere((order) => order.orderId == orderId));
      } else {
        _handleError(response);
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}',
    };
  }

  void _handleError(http.Response response) {
    _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
