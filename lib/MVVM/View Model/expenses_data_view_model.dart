import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../Models/expenses_data_model.dart';

class ExpensesViewModel extends ChangeNotifier {
  List<ExpensesDataModel> _expenses = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ExpensesDataModel> get expenses => _expenses;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final String apiUrl = dotenv.env['apiUrl'] ?? '';
  final String token = dotenv.env['jwt_Secret'] ?? '';

  // Fetch all expenses
  Future<void> fetchExpenses() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("${apiUrl}expenses"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _expenses = jsonData.map((item) => ExpensesDataModel.fromJson(item)).toList();
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load expenses';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new expense
  Future<void> addExpense(ExpensesDataModel expense) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("${apiUrl}expenses"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(expense.toJson()),
      );

      if (response.statusCode == 201) {
        _expenses.add(expense);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to add expense';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update an existing expense
  Future<void> updateExpense(ExpensesDataModel expense) async {
    _isLoading = true;
    notifyListeners();
    final updatedExpense = UpdateExpensesModel(
      customerName: expense.customerName,
      description: expense.description,
      carDetails: expense.carDetails,
      expensesDate: expense.expensesDate,
      cost: expense.cost,
      remaining: expense.remaining,
    );

    try {
      final response = await http.put(
        Uri.parse('${apiUrl}expenses/${expense.expensesId}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(updatedExpense.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _expenses.indexWhere((e) => e.expensesId == expense.expensesId);
        if (index != -1) {
          _expenses[index] = expense;
        }
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to update expense';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete an expense
  Future<void> deleteExpense(int expensesId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('${apiUrl}expenses/$expensesId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _expenses.removeWhere((expense) => expense.expensesId == expensesId);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to delete expense';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
