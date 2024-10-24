import 'package:bookingcars/MVVM/Models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TaskViewModel extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String _errorMessage = '';
  late Box<TaskModel> _taskBox; // Hive box for tasks

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Initialize Hive and load cached tasks
  Future<void> _initializeHive() async {
    await Hive.initFlutter(); // Initialize Hive

    // Check if adapter is already registered to avoid double registration
    if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
      Hive.registerAdapter(TaskModelAdapter()); // Register adapter for TaskModel
    }

    // Check if the box is already open to avoid re-opening
    if (!Hive.isBoxOpen('tasksBox')) {
      _taskBox = await Hive.openBox<TaskModel>('tasksBox'); // Open the Hive box for tasks
    } else {
      _taskBox = Hive.box<TaskModel>('tasksBox'); // Use already opened box
    }

    // Load cached data if available
    _tasks = _taskBox.values.toList();
    notifyListeners(); // Notify listeners after loading cached data
  }

  // Fetch all tasks from the API or cache
  Future<void> fetchTasks() async {
    _setLoading(true);
    await dotenv.load(fileName: ".env");

    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['apiUrl']}tasks'),
        headers: {'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}'},
      );

      if (response.statusCode == 200) {
        _tasks = taskModelFromJson(response.body);
        // Cache the fetched tasks
        _taskBox.clear(); // Clear old cached data
        for (var task in _tasks) {
          _taskBox.put(task.taskId, task);
        }
        _setErrorMessage('');
      } else {
        _tasks = [];
        _setErrorMessage('Failed to load tasks');
      }
    } catch (e) {
      _setErrorMessage('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Rest of your methods...}


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

      if (response.statusCode == 201) {
        _tasks.add(task);

        // Cache the new task
        await _taskBox.put(task.taskId, task);
        notifyListeners();
        _setErrorMessage('');
      } else {
        _setErrorMessage('Failed to add task');
      }
    } catch (e) {
      _setErrorMessage('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update an existing task
  Future<void> updateTask(TaskModel task) async {
    _setLoading(true);
    try {
      final response = await http.put(
        Uri.parse('${dotenv.env['apiUrl']}tasks/${task.taskId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}',
        },
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode == 200) {
        final index = _tasks.indexWhere((t) => t.taskId == task.taskId);
        if (index != -1) {
          _tasks[index] = task;

          // Update cache
          await _taskBox.put(task.taskId, task);
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
      final response = await http.delete(
        Uri.parse('${dotenv.env['apiUrl']}tasks/$taskId'),
        headers: {'Authorization': 'Bearer ${dotenv.env['jwt_Secret']}'},
      );

      if (response.statusCode == 200) {
        _tasks.removeWhere((task) => task.taskId == taskId);

        // Remove from cache
        await _taskBox.delete(taskId);
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

  // Fetch tasks from local Hive cache only
  Future<void> fetchTasksFromLocal() async {
    _setLoading(true);
    try {
      // Retrieve tasks from local cache
      if (_taskBox.isNotEmpty) {
        _tasks = List<TaskModel>.from(_taskBox.values);
        _setErrorMessage('');
      } else {
        _tasks = [];
        _setErrorMessage('No tasks found in local cache');
      }
    } catch (e) {
      _setErrorMessage('Error loading local tasks: $e');
    } finally {
      _setLoading(false);
      notifyListeners();
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
