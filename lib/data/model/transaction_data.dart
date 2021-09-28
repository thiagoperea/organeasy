import 'dart:convert';

import 'package:hive/hive.dart';

class TransactionData extends HiveObject {
  //   val transactionId: Int = 0,
  //   val userId: String,
  //   val walletId: Int,
  final int walletId;

  //   var transactionType: Int,
  //   var categoryId: Int? = null,
  //   var objectiveId: Int? = null,
  final int transactionType;
  final int? categoryId;
  final int? objectiveId;

  //   var description: String,
  //   var dueDate: Date,
  //   var totalValue: Double,
  //   var isDone: Boolean
  final String description;
  final DateTime dueDate;
  final double value;
  final bool isDone;

  TransactionData({
    required this.walletId,
    required this.transactionType,
    this.categoryId,
    this.objectiveId,
    required this.description,
    required this.dueDate,
    required this.value,
    required this.isDone,
  });

  TransactionData copyWith({
    int? walletId,
    int? transactionType,
    int? categoryId,
    int? objectiveId,
    String? description,
    DateTime? dueDate,
    double? value,
    bool? isDone,
  }) {
    return TransactionData(
      walletId: walletId ?? this.walletId,
      transactionType: transactionType ?? this.transactionType,
      categoryId: categoryId ?? this.categoryId,
      objectiveId: objectiveId ?? this.objectiveId,
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
      'objectiveId': objectiveId,
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
      objectiveId: map['objectiveId'],
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
    return 'TransactionData(walletId: $walletId, transactionType: $transactionType, categoryId: $categoryId, objectiveId: $objectiveId, description: $description, dueDate: $dueDate, value: $value, isDone: $isDone)';
  }
}

enum TransactionType { pay, receive, save }
