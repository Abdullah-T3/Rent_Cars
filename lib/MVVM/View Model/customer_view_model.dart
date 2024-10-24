import 'package:bookingcars/MVVM/Models/customers/CustomersDataModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomerViewModel extends ChangeNotifier {
  List<CustomersDataModel> _customers = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<CustomersDataModel> get customers => _customers;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  final String _baseUrl = '${dotenv.env['apiUrl']}customers';
  Box<CustomersDataModel>? _customersBox;

  CustomerViewModel() {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(CustomersDataModelAdapter().typeId)) {
      Hive.registerAdapter(CustomersDataModelAdapter());
    }
    _customersBox = await Hive.openBox<CustomersDataModel>('customersBox');
    _customers = _customersBox?.values.toList() ?? [];
    notifyListeners();
  }

  Future<void> fetchCustomers() async {
    _setLoading(true);
    try {
      var request = http.Request('GET', Uri.parse(_baseUrl));
      request.headers.addAll(_headers());

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var strings = await response.stream.bytesToString();
        List jsonData = json.decode(strings);

        _customers = jsonData
            .map<CustomersDataModel>((json) => CustomersDataModel.fromJson(json))
            .toList();

        // Cache the fetched data
        await _customersBox?.clear();
        for (var customer in _customers) {
          await _customersBox?.add(customer);
        }

        _errorMessage = '';
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

  Future<void> addCustomer(CustomersDataModel customer) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers(),
        body: jsonEncode(customer.toJson()),
      );
      if (response.statusCode == 201) {
        _customers.add(customer);
        await _customersBox?.add(customer);
        _errorMessage = '';
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

  Future<void> updateCustomer(CustomersDataModel customer) async {
    _setLoading(true);
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${customer.customerId}'),
        headers: _headers(),
        body: jsonEncode(customer.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _customers.indexWhere((c) => c.customerId == customer.customerId);
        if (index != -1) {
          _customers[index] = customer;
          await _customersBox?.putAt(index, customer);
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

  Future<void> deleteCustomer(int customerId) async {
    _setLoading(true);
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$customerId'),
        headers: _headers(),
      );
      if (response.statusCode == 200) {
        _customers.removeWhere((customer) => customer.customerId == customerId);
        await _customersBox?.deleteAt(_customers.indexWhere((customer) => customer.customerId == customerId));
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
