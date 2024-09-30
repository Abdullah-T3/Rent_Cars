import 'package:bookingcars/MVVM/Models/cars_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarsViewModel extends ChangeNotifier {
  List<CarsDataModel> _cars = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<CarsDataModel> get cars => _cars;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  final String _baseUrl = '${dotenv.env['apiUrl']}cars';
  Box<CarsDataModel>? _carsBox;

  CarsViewModel() {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.initFlutter(); // Initialize Hive
    // Check if adapter is already registered to avoid registering it again
  if (!Hive.isAdapterRegistered(CarsDataModelAdapter().typeId)) {
    Hive.registerAdapter(CarsDataModelAdapter()); // Register the adapter only if not already registered
  }
 _carsBox = await Hive.openBox<CarsDataModel>('carsBox'); // Open the Hive box for cars

    // Load cached data if available
    _cars = _carsBox?.values.toList() ?? [];
    notifyListeners();
  }

  Future<void> fetchCars() async {
    _setLoading(true);
    try {
      var request = http.Request('GET', Uri.parse(_baseUrl));
      request.headers.addAll(_headers());

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var strings = await response.stream.bytesToString();
        List jsonData = json.decode(strings);

        // Convert the JSON to CarsDataModel list
        _cars = jsonData.map((json) => CarsDataModel.fromJson(json)).toList();

        // Cache the fetched data in Hive
        await _carsBox?.clear(); // Clear old cache
        for (var car in _cars) {
          await _carsBox?.add(car); // Add each car to the cache
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

  /// Fetch cars data from local cache
  Future<void> fetchLocalCars() async {
    _setLoading(true);
    try {
      // Retrieve data from Hive local cache
      _cars = _carsBox?.values.toList() ?? [];
      // Notify UI listeners that the data has changed
      _errorMessage = '';
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
        await _carsBox?.add(car); // Cache the new car
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
          await _carsBox?.putAt(index, car); // Update the cache
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
        await _carsBox?.deleteAt(_cars.indexWhere((car) => car.license_plate == plateNumber)); // Remove from cache
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
