import 'package:hive/hive.dart';

class GoalData extends HiveObject {
  final int id;
  final String description;
  final DateTime dueDate; // ! TODO: or String parsed
  final double goalValue;
  final double currentValue;

  GoalData({
    required this.id,
    required this.description,
    required this.dueDate,
    required this.goalValue,
    required this.currentValue,
  });

  GoalData copyWith({
    int? id,
    String? description,
    DateTime? dueDate,
    double? goalValue,
    double? currentValue,
  }) {
    return GoalData(
      id: id ?? this.id,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      goalValue: goalValue ?? this.goalValue,
      currentValue: currentValue ?? this.currentValue,
    );
  }

  @override
  String toString() {
    return 'GoalData(id: $id, description: $description, dueDate: $dueDate, goalValue: $goalValue, currentValue: $currentValue)';
  }
}
