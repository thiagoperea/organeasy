part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<TransactionData> dataset;

  TransactionsLoaded(this.dataset);
}

class TransactionsError extends TransactionsState {}
