// To parse this JSON data, do
//
//     final expensesDataModel = expensesDataModelFromJson(jsonString);

import 'dart:convert';

List<ExpensesDataModel> expensesDataModelFromJson(String str) => List<ExpensesDataModel>.from(json.decode(str).map((x) => ExpensesDataModel.fromJson(x)));

String expensesDataModelToJson(List<ExpensesDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpensesDataModel {
    int? expensesId;
    int? projectId;
    String? customerName;
    String? description;
    String? carDetails;
    DateTime? expensesDate;
    String? cost;
    String? remaining;

    ExpensesDataModel({
        this.expensesId,
        this.projectId,
        this.customerName,
        this.description,
        this.carDetails,
        this.expensesDate,
        this.cost,
        this.remaining,
    });

    factory ExpensesDataModel.fromJson(Map<String, dynamic> json) => ExpensesDataModel(
        expensesId: json["Expenses_id"],
        projectId: json["project_id"],
        customerName: json["customer_name"],
        description: json["description"],
        carDetails: json["car_details"],
        expensesDate: json["Expenses_date"] == null ? null : DateTime.parse(json["Expenses_date"]),
        cost: json["cost"],
        remaining: json["remaining"],
    );

    Map<String, dynamic> toJson() => {
        "Expenses_id": expensesId,
        "project_id": projectId,
        "customer_name": customerName,
        "description": description,
        "car_details": carDetails,
        "Expenses_date": expensesDate?.toIso8601String(),
        "cost": cost,
        "remaining": remaining,
    };
}
