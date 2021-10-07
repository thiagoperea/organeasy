import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:organeasy/data/model/transaction_data.dart';

class TransactionRepository {
  static final String _transactionRefs = "refs";

  Future<void> addTransaction(TransactionData transaction) async {
    await Future.delayed(Duration(seconds: 3));

    final transactionBoxKey = DateFormat.yM().format(transaction.dueDate);
    _addKeyToRefs(transactionBoxKey);

    final db = await Hive.openBox<TransactionData>(transactionBoxKey);
    db.add(transaction);
  }

  /// If needed, add the [transactionBoxKey] to a database called [_transactionRefs].
  /// This database will be used to a import-export feature in future.
  /// * FIXME: THIS FEATURE IS NOT IMPLEMENTED
  Future<void> _addKeyToRefs(String transactionBoxKey) async {
    final dbRefs = await Hive.openBox<String>(_transactionRefs);
    final bool hasRegister = dbRefs.values.contains(transactionBoxKey);

    if (!hasRegister) {
      dbRefs.add(transactionBoxKey);
      //TODO: THIS BOX IS NOT CLOSED!!!
    }
  }
}
