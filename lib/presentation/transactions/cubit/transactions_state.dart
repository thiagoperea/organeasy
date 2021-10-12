part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState {
  final String selectedMonth;

  TransactionsState(this.selectedMonth);
}

class TransactionsLoading extends TransactionsState {
  TransactionsLoading(String selectedMonth) : super(selectedMonth);
}

class TransactionsLoaded extends TransactionsState {
  final List<TransactionData> dataset;

  TransactionsLoaded(String selectedMonth, this.dataset) : super(selectedMonth);
}

class TransactionsError extends TransactionsState {
  TransactionsError(String selectedMonth) : super(selectedMonth);
}
