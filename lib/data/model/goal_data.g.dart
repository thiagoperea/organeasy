// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalDataAdapter extends TypeAdapter<GoalData> {
  @override
  final int typeId = 1;

  @override
  GoalData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalData(
      id: fields[0] as int,
      description: fields[1] as String,
      dueDate: fields[2] as DateTime,
      goalValue: fields[3] as double,
      currentValue: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, GoalData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.goalValue)
      ..writeByte(4)
      ..write(obj.currentValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GoalDataAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
