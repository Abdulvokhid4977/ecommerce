// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationElementAdapter extends TypeAdapter<LocationElement> {
  @override
  final int typeId = 5;

  @override
  LocationElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationElement(
      id: fields[1] as String,
      name: fields[2] as String,
      info: fields[3] as String,
      latitude: fields[4] as double,
      longitude: fields[5] as double,
      image: fields[6] as String,
      createdAt: fields[7] as String,
      opensAt: fields[8] as String?,
      closesAt: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocationElement obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.info)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.opensAt)
      ..writeByte(9)
      ..write(obj.closesAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
