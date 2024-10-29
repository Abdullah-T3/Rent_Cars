import 'dart:convert';

import 'package:hive/hive.dart';

part 'CustomersDataModel.g.dart';
List<CustomersDataModel> customersDataModelFromJson(String str) => List<CustomersDataModel>.from(json.decode(str).map((x) => CustomersDataModel.fromJson(x)));

String customersDataModelToJson(List<CustomersDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId:3 ) // Ensure the typeId is unique
class CustomersDataModel {
    @HiveField(0)
    int? customerId;

    @HiveField(1)
    String? customerName;

    @HiveField(2)
    int? mobileNumber;

    @HiveField(3)
    String? idNumber;

    @HiveField(4)
    String? address;

    @HiveField(5)
    String? landline;

    @HiveField(6)
    String? referenceNumber;

    @HiveField(7)
    int? projectId;

    CustomersDataModel({
        this.customerId,
        this.customerName,
        this.mobileNumber,
        this.idNumber,
        this.address,
        this.landline,
        this.referenceNumber,
        this.projectId,
    });

    factory CustomersDataModel.fromJson(Map<String, dynamic> json) => CustomersDataModel(
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        mobileNumber: json["mobile_number"],
        idNumber: json["id_number"],
        address: json["address"],
        landline: json["landline"],
        referenceNumber: json["reference_number"],
        projectId: json["project_id"],
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "mobile_number": mobileNumber,
        "id_number": idNumber,
        "address": address,
        "landline": landline,
        "reference_number": referenceNumber,
        "project_id": projectId,
    };
}


