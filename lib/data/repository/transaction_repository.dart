import 'package:hive_flutter/hive_flutter.dart';
import 'package:organeasy/data/model/monthly_balance_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/data/model/transaction_type.dart';

class TransactionRepository {
  static const String monthlyBalanceBox = "monthly_balance";

  _getTransactionRef(DateTime dueDate) => "${dueDate.month}${dueDate.year}";

  Future<void> addTransaction(TransactionData transaction) async {
    await Future.delayed(Duration(seconds: 1));

    final periodKey = _getTransactionRef(transaction.dueDate);
    final transactionDb = await Hive.openBox<TransactionData>(periodKey);

    try {
      transactionDb.add(transaction);
      _addToMonthlyBalance(transaction, periodKey);
    } on Exception catch (error) {
      // TODO: log error
    }
  }

  Future<List<TransactionData>> getTransactionsFromMonth(DateTime dateTime) async {
    await Future.delayed(Duration(seconds: 1));

    final db = await Hive.openBox<TransactionData>(_getTransactionRef(dateTime));

    final dataset = db.values.toList(growable: false);
    dataset.sort((entry, nextEntry) => entry.dueDate.compareTo(nextEntry.dueDate));

    return dataset;
  }

  /// Add the [transaction] to the [periodKey]'s monthly balance.
  Future<void> _addToMonthlyBalance(TransactionData transaction, String periodKey) async {
    final database = await Hive.openBox<MonthlyBalanceData>(monthlyBalanceBox);

    MonthlyBalanceData monthlyBalance = database.get(periodKey, defaultValue: MonthlyBalanceData())!;

    switch (transaction.transactionType) {
      case TransactionType.expense:
        monthlyBalance.totalExpense += transaction.value;
        break;
      case TransactionType.income:
        monthlyBalance.totalIncome += transaction.value;
        break;
      case TransactionType.investment:
        monthlyBalance.totalInvestments += transaction.value;
        break;
    }

    database.put(periodKey, monthlyBalance);

    ///
    /// TODO: Create the delete and the update method;
    ///
  }
}
