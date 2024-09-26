import 'package:bookingcars/MVVM/Models/cars_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarsViewModel extends ChangeNotifier {
  List<CarsDataModel> _cars = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<CarsDataModel> get cars => _cars;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  final String _baseUrl = '${dotenv.env['apiUrl']}cars'; // Update with your actual API URL

  Future<void> fetchCars() async {
    _setLoading(true);
    try {
 var request = http.Request('GET', Uri.parse(_baseUrl));
request.headers.addAll(_headers());

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  var strings = await response.stream.bytesToString();
  List jsonData = json.decode(strings);
      _cars = jsonData.map((json) => CarsDataModel.fromJson(json)).toList();
      print('Cars fetched successfully: $cars');
      _errorMessage = '';
}
else {
  _handleError(response as http.Response);
}
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> addCar(CarsDataModel car) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers(),
        body: jsonEncode(car.toJson()),
      );
      if (response.statusCode == 201) {
        _cars.add(car);
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

  Future<void> updateCar(CarsDataModel car) async {
    _setLoading(true);
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${car.license_plate}'),
        headers: _headers(),
        body: jsonEncode(car.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _cars.indexWhere((c) => c.license_plate == car.license_plate);
        if (index != -1) {
          _cars[index] = car;
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

  Future<void> deleteCar(String plateNumber) async {
    _setLoading(true);
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$plateNumber'),
        headers: _headers(),
      );
      if (response.statusCode == 200) {
        _cars.removeWhere((car) => car.license_plate == plateNumber);
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
      'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}', // Replace with the actual token
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
