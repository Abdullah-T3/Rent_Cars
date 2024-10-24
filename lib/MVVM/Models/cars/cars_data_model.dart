import 'package:hive/hive.dart';

part 'cars_data_model.g.dart'; // Ensure this part is added for code generation

@HiveType(typeId: 1)
class CarsDataModel {
  @HiveField(0)
  // ignore: non_constant_identifier_names
  String? license_plate;

  @HiveField(1)
  String? brand;

  @HiveField(2)
  String? model;

  @HiveField(3)
  int? yearOfManufacture;

  @HiveField(4)
  int? odometerReading;

  @HiveField(5)
  int? nextOilChange;

  CarsDataModel({
    // ignore: non_constant_identifier_names
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
