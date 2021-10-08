import 'package:hive_flutter/hive_flutter.dart';
import 'package:organeasy/data/model/transaction_data.dart';

class TransactionRepository {
  static final String _transactionRefs = "refs";

  _getDatabaseRef(DateTime dueDate) {
    String key = "${dueDate.month}${dueDate.year}";
    _addKeyToRefs(key);
    return key;
  }

  /// If needed, add the [transactionBoxKey] to a database called [_transactionRefs].
  /// This database will be used to a import-export feature in future.
  /// * FIXME: THIS FEATURE IS NOT IMPLEMENTED
  Future<void> _addKeyToRefs(String transactionBoxKey) async {
    final dbRefs = await Hive.openBox<String>(_transactionRefs);
    final bool hasRegister = dbRefs.values.contains(transactionBoxKey);

    if (!hasRegister) {
      await dbRefs.add(transactionBoxKey);
      //TODO: THIS BOX IS NOT CLOSED!!!
    }
  }

  Future<void> addTransaction(TransactionData transaction) async {
    await Future.delayed(Duration(seconds: 1));

    final databaseRef = _getDatabaseRef(transaction.dueDate);
    final db = await Hive.openBox<TransactionData>(databaseRef);

    db.add(transaction);
  }

  Future<List<TransactionData>> getTransactionsFromMonth(DateTime dateTime) async {
    await Future.delayed(Duration(seconds: 1));

    final databaseRef = _getDatabaseRef(dateTime);
    final db = await Hive.openBox<TransactionData>(databaseRef);

    final dataset = db.values.toList(growable: false);
    dataset.sort((entry, nextEntry) => entry.dueDate.compareTo(nextEntry.dueDate));

    return dataset;
  }
}
