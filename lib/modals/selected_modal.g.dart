// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectedAdapter extends TypeAdapter<Selected> {
  @override
  final int typeId = 1;

  @override
  Selected read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Selected(
      fields[0] as Exercise?,
      fields[1] as int?,
      fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Selected obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.exercise)
      ..writeByte(1)
      ..write(obj.set)
      ..writeByte(2)
      ..write(obj.rep);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
