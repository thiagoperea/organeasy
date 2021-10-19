part of 'load_transactions_cubit.dart';

class LoadTransactionsState {
  final LoadTransactionsStates state;
  final String selectedMonth;

  final List<TransactionData>? dataset;
  final String? errorMessage;

  LoadTransactionsState({required this.state, required this.selectedMonth, this.dataset, this.errorMessage});

  LoadTransactionsState copyWith({
    LoadTransactionsStates? state,
    String? selectedMonth,
    List<TransactionData>? dataset,
    String? errorMessage,
  }) {
    return LoadTransactionsState(
      state: state ?? this.state,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      dataset: dataset ?? this.dataset,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum LoadTransactionsStates { loading, success, error }
