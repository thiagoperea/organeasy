import 'package:organeasy/data/model/goal_data.dart';

class GoalRepository {
  final _goalsList = [
    GoalData(id: 0, description: "Casa", dueDate: DateTime.now(), goalValue: 20000.00, currentValue: 500.00),
    GoalData(id: 1, description: "Carro", dueDate: DateTime.now(), goalValue: 1000.00, currentValue: 700.00),
    GoalData(id: 2, description: "Computador", dueDate: DateTime.now(), goalValue: 5000.00, currentValue: 1500.00),
  ];

  Future<List<GoalData>> getGoalList() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(_goalsList);
  }
}
