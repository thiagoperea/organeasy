import 'package:hive/hive.dart';

part 'transaction_type.g.dart';

@HiveType(typeId: 4)
enum TransactionType {
  @HiveField(0)
  expense,

  @HiveField(1)
  income,

  @HiveField(2)
  investment,

  @HiveField(3)
  savings
}
