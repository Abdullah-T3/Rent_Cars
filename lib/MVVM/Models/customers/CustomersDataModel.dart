import 'package:hive/hive.dart';

part 'CustomersDataModel.g.dart';
@HiveType(typeId: 3) // Type ID should be unique in your app's Hive setup
class CustomersDataModel {
  @HiveField(0)
  int? customerId;

  @HiveField(1)
  String? customerName;

  @HiveField(2)
  String? idNumber;

  @HiveField(3)
  String? address;

  @HiveField(4)
  String? landline;

  @HiveField(5)
  String? referenceNumber;

  @HiveField(6)
  int? projectId;

  CustomersDataModel({
    this.customerId,
    this.customerName,
    this.idNumber,
    this.address,
    this.landline,
    this.referenceNumber,
    this.projectId,
  });

  // Factory method to create an instance from JSON
  factory CustomersDataModel.fromJson(Map<String, dynamic> json) => CustomersDataModel(
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        idNumber: json["id_number"],
        address: json["address"],
        landline: json["landline"],
        referenceNumber: json["reference_number"],
        projectId: json["project_id"],
      );

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "id_number": idNumber,
        "address": address,
        "landline": landline,
        "reference_number": referenceNumber,
        "project_id": projectId,
      };
}
