import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:organeasy/data/model/transaction_type.dart';

part 'transaction_data.g.dart';

@HiveType(typeId: 0)
class TransactionData extends HiveObject {
  @HiveField(0)
  final int walletId;

  @HiveField(1)
  final TransactionType transactionType;

  @HiveField(2)
  final int categoryId;

  @HiveField(3)
  final int? goalId;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final DateTime dueDate;

  @HiveField(6)
  final double value;

  @HiveField(7)
  final bool isDone;

  TransactionData({
    required this.walletId,
    required this.transactionType,
    required this.categoryId,
    this.goalId,
    required this.description,
    required this.dueDate,
    required this.value,
    required this.isDone,
  });

  TransactionData copyWith({
    int? walletId,
    TransactionType? transactionType,
    int? categoryId,
    int? goalId,
    String? description,
    DateTime? dueDate,
    double? value,
    bool? isDone,
  }) {
    return TransactionData(
      walletId: walletId ?? this.walletId,
      transactionType: transactionType ?? this.transactionType,
      categoryId: categoryId ?? this.categoryId,
      goalId: goalId ?? this.goalId,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      value: value ?? this.value,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'walletId': walletId,
      'transactionType': transactionType,
      'categoryId': categoryId,
      'goalId': goalId,
      'description': description,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'value': value,
      'isDone': isDone,
    };
  }

  factory TransactionData.fromMap(Map<String, dynamic> map) {
    return TransactionData(
      walletId: map['walletId'],
      transactionType: map['transactionType'],
      categoryId: map['categoryId'],
      goalId: map['goalId'],
      description: map['description'],
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      value: map['value'],
      isDone: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionData.fromJson(String source) => TransactionData.fromMap(json.decode(source));

  @override
  String toString() {
    return "TransactionData(walletId: $walletId, "
        "transactionType: $transactionType}, "
        "categoryId: $categoryId, "
        "goalId: $goalId, "
        "description: $description, "
        "dueDate: $dueDate, "
        "value: $value, "
        "isDone: $isDone)";
  }
}
