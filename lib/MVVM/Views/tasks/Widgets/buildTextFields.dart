  import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:flutter/material.dart';

Widget buildTextFields( titleController, descriptionController) {
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
