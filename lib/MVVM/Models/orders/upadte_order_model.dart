// To parse this JSON data, do
//
//     final updateOrdersModel = updateOrdersModelFromJson(jsonString);

import 'dart:convert';

UpdateOrdersModel updateOrdersModelFromJson(String str) => UpdateOrdersModel.fromJson(json.decode(str));

String updateOrdersModelToJson(UpdateOrdersModel data) => json.encode(data.toJson());

class UpdateOrdersModel {
    String? customerName;
    String? customerMobile;
    String? carLicensePlate;
    String? carName;
    DateTime? rentalDate;
    int? rentalAmount;
    int? rentalDays;
    int? carKmAtRental;

    UpdateOrdersModel({
        this.customerName,
        this.customerMobile,
        this.carLicensePlate,
        this.carName,
        this.rentalDate,
        this.rentalAmount,
        this.rentalDays,
        this.carKmAtRental,
    });

    factory UpdateOrdersModel.fromJson(Map<String, dynamic> json) => UpdateOrdersModel(
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        carLicensePlate: json["car_license_plate"],
        carName: json["car_name"],
        rentalDate: json["rental_date"] == null ? null : DateTime.parse(json["rental_date"]),
        rentalAmount: json["rental_amount"],
        rentalDays: json["rental_days"],
        carKmAtRental: json["car_km_at_rental"],
    );

    Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "car_license_plate": carLicensePlate,
        "car_name": carName,
        "rental_date": "${rentalDate!.year.toString().padLeft(4, '0')}-${rentalDate!.month.toString().padLeft(2, '0')}-${rentalDate!.day.toString().padLeft(2, '0')}",
        "rental_amount": rentalAmount,
        "rental_days": rentalDays,
        "car_km_at_rental": carKmAtRental,
    };
}
