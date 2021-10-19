import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organeasy/data/model/monthly_balance_data.dart';
import 'package:organeasy/data/repository/transaction_repository.dart';

class LoadMonthlyBalanceCubit extends Cubit<LoadMonthlyBalanceState> {
  final TransactionRepository _transactionRepository = TransactionRepository();

  LoadMonthlyBalanceCubit() : super(LoadMonthlyBalanceState(state: LoadMonthlyBalanceStates.collapsed));

  Future<void> expandOrCollapse(DateTime monthSelected) async {
    if (state.state == LoadMonthlyBalanceStates.expanded) {
      emit(state.copyWith(state: LoadMonthlyBalanceStates.collapsed));
    } else {
      await _expand(monthSelected);
    }
  }

  Future<void> _expand(DateTime monthSelected) async {
    emit(state.copyWith(
      state: LoadMonthlyBalanceStates.loading,
    ));

    try {
      final MonthlyBalanceData data = await _transactionRepository.getMonthlyBalance(monthSelected);

      emit(state.copyWith(
        state: LoadMonthlyBalanceStates.expanded,
        data: data,
      ));
    } on Exception catch (error) {
      //TODO: logError
      emit(state.copyWith(
        state: LoadMonthlyBalanceStates.collapsed,
      ));
    }
  }

  void refreshExpanded(DateTime monthSelected) {
    if (state.state == LoadMonthlyBalanceStates.expanded || state.state == LoadMonthlyBalanceStates.loading) {
      _expand(monthSelected);
    }
  }
}

class LoadMonthlyBalanceState {
  final LoadMonthlyBalanceStates state;
  final MonthlyBalanceData? data;

  LoadMonthlyBalanceState({required this.state, this.data});

  LoadMonthlyBalanceState copyWith({
    LoadMonthlyBalanceStates? state,
    MonthlyBalanceData? data,
  }) {
    return LoadMonthlyBalanceState(
      state: state ?? this.state,
      data: data ?? this.data,
    );
  }
}

enum LoadMonthlyBalanceStates { collapsed, loading, expanded }
