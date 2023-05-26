// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmileModelAdapter extends TypeAdapter<SmileModel> {
  @override
  final int typeId = 2;

  @override
  SmileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmileModel(
      date: fields[0] as DateTime,
      item: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SmileModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.item);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
