// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarsDataModelAdapter extends TypeAdapter<CarsDataModel> {
  @override
  final int typeId = 1;

  @override
  CarsDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarsDataModel(
      license_plate: fields[0] as String?,
      model: fields[2] as String?,
      brand: fields[1] as String?,
      yearOfManufacture: fields[3] as int?,
      odometerReading: fields[4] as int?,
      nextOilChange: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CarsDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.license_plate)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.yearOfManufacture)
      ..writeByte(4)
      ..write(obj.odometerReading)
      ..writeByte(5)
      ..write(obj.nextOilChange);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarsDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
