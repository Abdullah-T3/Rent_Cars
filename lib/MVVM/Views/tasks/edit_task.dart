import 'package:bookingcars/MVVM/Views/tasks/Widgets/buildTextFields.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:flutter/material.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override 
  Widget build(BuildContext context) {
    return Infowidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Task"),
        ),
        body: Container(
          padding: EdgeInsets.all(deviceInfo.screenWidth * 0.05),
          child: Column(
            children: [
              buildTextFields( titleController, descriptionController),
            ],
            ),
        ),
      );
    });
  }
}