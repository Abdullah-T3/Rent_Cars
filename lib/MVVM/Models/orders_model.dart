// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
    int? orderId;
    String? customerName;
    String? customerMobile;
    String? carLicensePlate;
    String? carName;
    DateTime? rentalDate;
    int? rentalDays;
    int? rentalAmount;
    int? carKmAtRental;
    DateTime? createdAt;

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
    };
}
