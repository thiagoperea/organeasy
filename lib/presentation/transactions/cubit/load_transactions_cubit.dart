import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/data/repository/category_repository.dart';
import 'package:organeasy/data/repository/transaction_repository.dart';

part 'load_transactions_state.dart';

class LoadTransactionsCubit extends Cubit<LoadTransactionsState> {
  final TransactionRepository _transactionRepository = TransactionRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<CategoryData> _categoryList = List.empty(growable: false);
  DateTime monthSelected = DateTime.now();

  LoadTransactionsCubit()
      : super(LoadTransactionsState(
          state: LoadTransactionsStates.loading,
          selectedMonth: DateFormat.yM().format(DateTime.now()),
        )) {
    _loadCategoryList();
  }

  /// Load category list to build the Transaction list.
  Future<void> _loadCategoryList() async {
    _categoryList = await _categoryRepository.getCategoryList();
  }

  /// Load all transactions from the selected month.
  Future<void> loadTransactions() async {
    emit(state.copyWith(
      state: LoadTransactionsStates.loading,
      selectedMonth: getMonthFormatted(),
    ));

    try {
      List<TransactionData> _dataset = await _transactionRepository.getTransactionsFromMonth(monthSelected);

      emit(state.copyWith(
        state: LoadTransactionsStates.success,
        dataset: _dataset,
      ));
    } on Exception catch (error) {
      //TODO: logError(error)
      emit(state.copyWith(
        state: LoadTransactionsStates.error,
        errorMessage: error.toString(),
      ));
    }
  }

  /// Get the category with id == [categoryId].
  CategoryData getCategory(int categoryId) => _categoryList.firstWhere((element) => element.id == categoryId);

  void setPreviousMonth() {
    monthSelected = DateTime(monthSelected.year, monthSelected.month - 1, monthSelected.day);
    loadTransactions();
  }

  void setNextMonth() {
    monthSelected = DateTime(monthSelected.year, monthSelected.month + 1, monthSelected.day);
    loadTransactions();
  }

  String getMonthFormatted() => DateFormat.yM().format(monthSelected);
}
