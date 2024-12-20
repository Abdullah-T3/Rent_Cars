import 'dart:convert';
import 'package:hive/hive.dart';

part 'orders_model.g.dart';

@HiveType(typeId: 0)
class OrdersModel {
  @HiveField(0)
  int? orderId;

  @HiveField(1)
  String? customerName;

  @HiveField(2)
  String? customerMobile;

  @HiveField(3)
  String? carLicensePlate;

  @HiveField(4)
  String? carName;

  @HiveField(5)
  DateTime? rentalDate;

  @HiveField(6)
  int? rentalDays;

  @HiveField(7)
  int? rentalAmount;

  @HiveField(8)
  int? carKmAtRental;

  @HiveField(9)
  DateTime? createdAt;

  @HiveField(10)
  String? imageUrl; // Changed from dynamic to String for consistency

  OrdersModel({
    this.orderId,
    this.customerName,
    this.customerMobile,
    this.carLicensePlate,
    this.carName,
    this.rentalDate,
    this.rentalDays,
    this.rentalAmount,
    this.carKmAtRental,
    this.createdAt,
    this.imageUrl,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        orderId: json["order_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        carLicensePlate: json["car_license_plate"],
        carName: json["car_name"],
        rentalDate: json["rental_date"] == null ? null : DateTime.parse(json["rental_date"]),
        rentalDays: json["rental_days"],
        rentalAmount: json["rental_amount"],
        carKmAtRental: json["car_km_at_rental"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        imageUrl: json["image_url"] as String?, // Typecast to String?
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "car_license_plate": carLicensePlate,
        "car_name": carName,
        "rental_date": rentalDate?.toIso8601String(),
        "rental_days": rentalDays,
        "rental_amount": rentalAmount,
        "car_km_at_rental": carKmAtRental,
        "created_at": createdAt?.toIso8601String(),
        "image_url": imageUrl,
      };
}

// Functions to parse JSON data
List<OrdersModel> ordersModelFromJson(String str) =>
    List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
