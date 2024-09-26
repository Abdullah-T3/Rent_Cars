// To parse this JSON data, do
//
//     final carsDataModel = carsDataModelFromJson(jsonString);

import 'dart:convert';

List<CarsDataModel> carsDataModelFromJson(String str) => List<CarsDataModel>.from(json.decode(str).map((x) => CarsDataModel.fromJson(x)));

String carsDataModelToJson(List<CarsDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarsDataModel {
    String? license_plate;
    String? brand;
    String? model;
    int? yearOfManufacture;
    int? odometerReading;
    int? nextOilChange;

    CarsDataModel({
        this.license_plate,
        this.model,
        this.brand,
        this.yearOfManufacture,
        this.odometerReading,
        this.nextOilChange,
    });

    factory CarsDataModel.fromJson(Map<String, dynamic> json) => CarsDataModel(
        license_plate: json["license_plate"],
        brand: json["brand"],
        model: json["model"],
        yearOfManufacture: json["year_of_manufacture"],
        odometerReading: json["odometer_reading"],
        nextOilChange: json["next_oil_change"],
    );

    Map<String, dynamic> toJson() => {
        "license_plate": license_plate,
        "brand": brand,
        "model": model,
        "year_of_manufacture": yearOfManufacture,
        "odometer_reading": odometerReading,
        "next_oil_change": nextOilChange,
    };
}
