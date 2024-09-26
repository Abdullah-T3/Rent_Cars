import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch all tasks from the API
  Future<void> fetchTasks() async {
    _setLoading(true);
    await dotenv.load(fileName: ".env");
    try {
      final response = await http.get(Uri.parse('${dotenv.env['apiUrl']}tasks'),
          headers: {'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}'});

      if (response.statusCode == 200) {
        _tasks = taskModelFromJson(response.body);
        _setErrorMessage('');
      } else {
        _setErrorMessage('Failed to load tasks');
      }
    } catch (e) {
      _setErrorMessage('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Add a new task
  Future<void> addTask(TaskModel task) async {
    await dotenv.load(fileName: ".env");
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['apiUrl']}tasks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}'
        },
        body: jsonEncode(task.toJson()),
      );
      print(response.body);
      if (response.statusCode == 201) {
        _tasks.add(task);
        notifyListeners();
        _setErrorMessage('');
      } else {
        print(response.body);
        _setErrorMessage('Failed to add task');
      }
    } catch (e) {
      _setErrorMessage('Error: $e');
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  // Update an existing task
  Future<void> updateTask(TaskModel task) async {
    _setLoading(true);
    try {
      final response = await http.put(
        Uri.parse('${dotenv.env['apiUrl']}tasks/${task.taskId}',
        ),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}',
        },
        body: jsonEncode(task.toJson()),
      );
      if (response.statusCode == 200) {
        final index = _tasks.indexWhere((t) => t.taskId == task.taskId);
        if (index != -1) {
          _tasks[index] = task;
          notifyListeners();
        }
        _setErrorMessage('');
      } else {
        _setErrorMessage('Failed to update task');
      }
    } catch (e) {
      _setErrorMessage('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Delete a task
  Future<void> deleteTask(int taskId) async {
    _setLoading(true);
    try {
      final response = await http.delete(Uri.parse('${dotenv.env['apiUrl']}tasks/$taskId'),
          headers: {'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}'}
      );
      if (response.statusCode == 200) {
        _tasks.removeWhere((task) => task.taskId == taskId);
        notifyListeners();
        _setErrorMessage('');
      } else {
        _setErrorMessage('Failed to delete task');
      }
    } catch (e) {
      _setErrorMessage('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Helper methods to manage loading and errors
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
