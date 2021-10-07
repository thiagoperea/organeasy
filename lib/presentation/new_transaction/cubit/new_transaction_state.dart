part of 'new_transaction_cubit.dart';

@immutable
abstract class NewTransactionState {}

class LoadingScreen extends NewTransactionState {}

class ScreenLoaded extends NewTransactionState {}

class SavingTransaction extends NewTransactionState {}

class TransactionSaved extends NewTransactionState {}

class TransactionError extends NewTransactionState {}
