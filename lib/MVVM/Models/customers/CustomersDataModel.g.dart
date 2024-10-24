// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomersDataModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomersDataModelAdapter extends TypeAdapter<CustomersDataModel> {
  @override
  final int typeId = 3;

  @override
  CustomersDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomersDataModel(
      customerId: fields[0] as int?,
      customerName: fields[1] as String?,
      idNumber: fields[2] as String?,
      address: fields[3] as String?,
      landline: fields[4] as String?,
      referenceNumber: fields[5] as String?,
      projectId: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CustomersDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.customerId)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.idNumber)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.landline)
      ..writeByte(5)
      ..write(obj.referenceNumber)
      ..writeByte(6)
      ..write(obj.projectId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomersDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
