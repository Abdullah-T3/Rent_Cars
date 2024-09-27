import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _currentUser; // Stores the current user data
  String _token = ''; // Stores the authentication token
  String _errorMessage = ''; // Stores error messages
  bool _isLoading = false; // Indicates loading state

  UserModel? get currentUser => _currentUser;
  String get token => _token;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  // Register a new user
  Future<void> register(UserModel userModel) async {
    _isLoading = true;
    notifyListeners();
    await dotenv.load(fileName: ".env");

    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['apiUrl']}users/register'),
        headers: {'Content-Type': 'application/json'},
        body: userModelToJson(userModel),  // Convert UserModel to JSON
      );

      if (response.statusCode == 201) {
        _errorMessage = '';
      } else {
        final errorData = json.decode(response.body);
        _errorMessage = errorData['errors']?.first['msg'] ?? 'Registration failed';
      }
    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Login user
  Future<void> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
 await dotenv.load(fileName: ".env");
    try {
     
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}'
};
var request = http.Request('POST', Uri.parse('${dotenv.env['apiUrl']}users/login'));
request.body = json.encode({
  "username": username,
  "password": password
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var json = await response.stream.bytesToString();
        Map<String, dynamic> data = jsonDecode(json);
        _token =  data['token'];
        _errorMessage = '';
        // Save token using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token);
      } else {
        _errorMessage = 'Invalid credentials';
      }

    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  // Check project ID
  Future<bool> checkProjectId(String projectId) async {
    _isLoading = true;
    notifyListeners();

    bool isValidProject = false;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('${dotenv.env['apiUrl']}check-project?project_id=$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        isValidProject = true;
        _errorMessage = '';
      } else {
        _errorMessage = 'Project ID does not match';
      }
    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
    return isValidProject;
  }

  // Fetch all users (protected route)
  Future<void> fetchAllUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final response = await http.get(
        Uri.parse('${dotenv.env['apiUrl']}/users'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<UserModel> users = (jsonDecode(response.body) as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
        // Handle users list in the ViewModel
        _errorMessage = '';
      } else {
        _errorMessage = 'Failed to fetch users';
      }
    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Log out the user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = '';
    _currentUser = null;
    notifyListeners();
  }

    // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    return _token.isNotEmpty;
  }
}
