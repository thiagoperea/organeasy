import 'package:hive/hive.dart';

part 'monthly_balance_data.g.dart';

@HiveType(typeId: 3)
class MonthlyBalanceData {
  @HiveField(0)
  double totalIncome;

  @HiveField(1)
  double totalExpense;

  @HiveField(2)
  double totalInvestments;

  @HiveField(3)
  double totalSavings;

  MonthlyBalanceData({
    this.totalIncome = 0.0,
    this.totalExpense = 0.0,
    this.totalInvestments = 0.0,
    this.totalSavings = 0.0,
  });
}
