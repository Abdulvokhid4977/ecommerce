// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductElementAdapter extends TypeAdapter<ProductElement> {
  @override
  final int typeId = 0;

  @override
  ProductElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductElement(
      id: fields[0] as String,
      categoryId: fields[1] as String,
      favorite: fields[2] as bool,
      name: fields[3] as String,
      price: fields[4] as int,
      withDiscount: fields[5] as int,
      rating: fields[6] as int,
      description: fields[7] as String,
      itemCount: fields[8] as int,
      color: (fields[9] as List).cast<ProductColor>(),
      createdAt: fields[10] as String,
      status: fields[11] as String?,
      discountPercent: fields[12] as int?,
      discountEndTime: fields[13] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductElement obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.favorite)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.withDiscount)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.itemCount)
      ..writeByte(9)
      ..write(obj.color)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.discountPercent)
      ..writeByte(13)
      ..write(obj.discountEndTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductColorAdapter extends TypeAdapter<ProductColor> {
  @override
  final int typeId = 1;

  @override
  ProductColor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductColor(
      id: fields[0] as String,
      productId: fields[1] as String,
      colorName: fields[2] as String,
      colorUrl: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductColor obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.colorName)
      ..writeByte(3)
      ..write(obj.colorUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
