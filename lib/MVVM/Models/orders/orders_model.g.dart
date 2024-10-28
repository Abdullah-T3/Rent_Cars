// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdersModelAdapter extends TypeAdapter<OrdersModel> {
  @override
  final int typeId = 0;

  @override
  OrdersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrdersModel(
      orderId: fields[0] as int?,
      customerName: fields[1] as String?,
      customerMobile: fields[2] as String?,
      carLicensePlate: fields[3] as String?,
      carName: fields[4] as String?,
      rentalDate: fields[5] as DateTime?,
      rentalDays: fields[6] as int?,
      rentalAmount: fields[7] as int?,
      carKmAtRental: fields[8] as int?,
      createdAt: fields[9] as DateTime?,
      imageUrl: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrdersModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.orderId)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.customerMobile)
      ..writeByte(3)
      ..write(obj.carLicensePlate)
      ..writeByte(4)
      ..write(obj.carName)
      ..writeByte(5)
      ..write(obj.rentalDate)
      ..writeByte(6)
      ..write(obj.rentalDays)
      ..writeByte(7)
      ..write(obj.rentalAmount)
      ..writeByte(8)
      ..write(obj.carKmAtRental)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
