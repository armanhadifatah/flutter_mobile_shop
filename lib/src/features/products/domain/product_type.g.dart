// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductTypeAdapter extends TypeAdapter<ProductType> {
  @override
  final int typeId = 2;

  @override
  ProductType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductType(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
    )..id = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, ProductType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
