import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Constants/Colors.dart';
import '../../View%20Model/task_view_model.dart';
import '../../models/task_model.dart';
import '../../../Responsive/UiComponanets/InfoWidget.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime now = DateTime.now();

  Widget buildTextFields() {
    return Infowidget(builder: (context, deviceInfo) {
      return Column(
        children: [
          TextField(
            controller: titleController,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(height: deviceInfo.screenWidth * 0.05),
          TextField(
            controller: descriptionController,
            cursorColor: Colors.white,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: "Description",
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget buildDateTimePicker() {
    return Infowidget(builder: (context, deviceInfo) {
      return InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: now,
            firstDate: DateTime(2024),
            lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    onSurface: Colors.white,
                  ),
                  dialogBackgroundColor: MyColors.bgColor,
                ),
                child: child!,
              );
            },
          );
          if (picked != null && picked != now) {
            setState(() {
              now = picked;
            });
          }
        },
        child: Container(
          height: deviceInfo.screenHeight * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
          ),
          child: ListTile(
            title: const Text(
              "Choose deadline: ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            trailing: Text(
              "${now.toLocal()}".split(' ')[0],
              style: const TextStyle(color: Colors.grey, fontSize: 19),
            ),
          ),
        )
      );
    });
  }

  Widget buildButton(Function()? onPressed) {
    return Infowidget(builder: (context, deviceInfo) {
      return SizedBox(
        height: deviceInfo.screenHeight * 0.07,
        width: deviceInfo.screenWidth * 0.8,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: const StadiumBorder(),
          ),
          onPressed: onPressed,
          child: const Text(
            "Add Task",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Task"),
        ),
        body: SizedBox(
          height: deviceInfo.screenHeight,
          width: deviceInfo.screenWidth,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              deviceInfo.screenWidth * 0.02,
              deviceInfo.screenHeight * 0.02,
              deviceInfo.screenWidth * 0.02,
              0,
            ),
            child: Column(
              children: [
                buildTextFields(),
                const SizedBox(height: 20),
                buildDateTimePicker(),
                SizedBox(height: deviceInfo.screenHeight * 0.1),
                buildButton(() async {
                  await taskViewModel.addTask(TaskModel(
                    taskTitle: titleController.text,
                    taskDescription: descriptionController.text,
                    deadline: now,
                    isCompleted: 1,
                    projectId: 123
                  )  );
                  
                  if (taskViewModel.errorMessage != null) {
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Error"),
                        content: Text(taskViewModel.errorMessage),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  } if(taskViewModel.errorMessage.isEmpty) {
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Success"),
                        content: const Text("Task added successfully"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('/home');
                            },
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
