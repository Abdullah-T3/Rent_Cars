// To parse this JSON data, do
//
//     final updateExpensesModel = updateExpensesModelFromJson(jsonString);

import 'dart:convert';

UpdateExpensesModel updateExpensesModelFromJson(String str) => UpdateExpensesModel.fromJson(json.decode(str));

String updateExpensesModelToJson(UpdateExpensesModel data) => json.encode(data.toJson());

class UpdateExpensesModel {
    int? projectId;
    String? customerName;
    String? description;
    String? carDetails;
    DateTime? expensesDate;
    int? cost;
    int? remaining;

    UpdateExpensesModel({
        this.projectId,
        this.customerName,
        this.description,
        this.carDetails,
        this.expensesDate,
        this.cost,
        this.remaining,
    });

    factory UpdateExpensesModel.fromJson(Map<String, dynamic> json) => UpdateExpensesModel(
        projectId: json["project_id"],
        customerName: json["customer_name"],
        description: json["description"],
        carDetails: json["car_details"],
        expensesDate: json["expenses_date"] == null ? null : DateTime.parse(json["expenses_date"]),
        cost: json["cost"],
        remaining: json["remaining"],
    );

    Map<String, dynamic> toJson() => {
        "project_id": projectId,
        "customer_name": customerName,
        "description": description,
        "car_details": carDetails,
        "expenses_date": "${expensesDate!.year.toString().padLeft(4, '0')}-${expensesDate!.month.toString().padLeft(2, '0')}-${expensesDate!.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "remaining": remaining,
    };
}
