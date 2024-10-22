import 'package:bookingcars/MVVM/Models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookingcars/MVVM/View%20Model/task_view_model.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.taskTitle);
    _descriptionController =
        TextEditingController(text: widget.task.taskDescription);
    _deadline = widget.task.deadline;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Use the correct field name
              taskViewModel.deleteTask(widget.task.taskId!);
              Navigator.pop(context); // Go back to the tasks list
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(

                controller: _titleController,
                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: "Description"),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Deadline:"),
                  TextButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _deadline ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _deadline) {
                        setState(() {
                          _deadline = picked;
                        });
                      }
                    },
                    child: Text(
                      _deadline != null
                          ? _deadline!.toLocal().toString().substring(0, 10)
                          : 'Select Date',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Call the ViewModel's update method
                    taskViewModel.updateTask(
                      TaskModel(
                        taskId:
                            widget.task.taskId, // Use the correct field name
                        taskTitle: _titleController.text,
                        taskDescription: _descriptionController.text,
                        deadline: _deadline,
                      ),
                    );
                    Navigator.pop(context); // Go back to the tasks list
                  }
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text("Update Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
