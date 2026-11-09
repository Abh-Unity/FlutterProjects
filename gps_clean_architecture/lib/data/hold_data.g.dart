// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class holddataAdapter extends TypeAdapter<hold_data> {
  @override
  final typeId = 0;

  @override
  hold_data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return hold_data(
      Longitude: (fields[0] as num).toDouble(),
      Latitude: fields[1] as dynamic,
      Altitude: fields[2] as dynamic,
      deviceid: fields[3] as dynamic,
      time: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, hold_data obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.Longitude)
      ..writeByte(1)
      ..write(obj.Latitude)
      ..writeByte(2)
      ..write(obj.Altitude)
      ..writeByte(3)
      ..write(obj.deviceid)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is holddataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
