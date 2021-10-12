import 'package:hive/hive.dart';

part 'goal_data.g.dart';

@HiveType(typeId: 1)
class GoalData extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime dueDate;

  @HiveField(3)
  final double goalValue;

  @HiveField(4)
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
