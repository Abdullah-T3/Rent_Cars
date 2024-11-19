import 'package:bookingcars/Constants/Colors.dart';
import 'package:bookingcars/Responsive/UiComponanets/InfoWidget.dart';
import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';

class BuildTimePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Callback for date selection

  const BuildTimePicker({super.key, required this.onDateSelected});

  @override
  State<BuildTimePicker> createState() => _BuildTimePickerState();
}

class _BuildTimePickerState extends State<BuildTimePicker> {
  DateTime now = DateTime.now(); // Initialize with current date

  @override
  Widget build(BuildContext context) {
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
            widget.onDateSelected(picked); // Pass the selected date back
          }
        },
        child: Container(
          height: deviceInfo.screenHeight * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
          ),
          child: ListTile(
            title:  Text(
             S.of(context).select_date,
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
        ),
      );
    });
  }
}