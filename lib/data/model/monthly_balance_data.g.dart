// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_balance_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyBalanceDataAdapter extends TypeAdapter<MonthlyBalanceData> {
  @override
  final int typeId = 3;

  @override
  MonthlyBalanceData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyBalanceData(
      totalIncome: fields[0] as double,
      totalExpense: fields[1] as double,
      totalInvestments: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyBalanceData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.totalIncome)
      ..writeByte(1)
      ..write(obj.totalExpense)
      ..writeByte(2)
      ..write(obj.totalInvestments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MonthlyBalanceDataAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
