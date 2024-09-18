// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemWrapperAdapter extends TypeAdapter<CartItemWrapper> {
  @override
  final int typeId = 2;

  @override
  CartItemWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemWrapper(
      product: fields[0] as ProductElement,
      quantity: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemWrapper obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
