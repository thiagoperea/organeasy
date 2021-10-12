import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/data/repository/category_repository.dart';
import 'package:organeasy/data/repository/transaction_repository.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final TransactionRepository _transactionRepository = TransactionRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<CategoryData> _categoryList = List.empty(growable: false);
  DateTime _monthSelected = DateTime.now();

  TransactionsCubit() : super(TransactionsLoading(DateFormat.yM().format(DateTime.now()))) {
    _loadCategoryList();
  }

  /// Load category list to build the Transaction list.
  Future<void> _loadCategoryList() async {
    _categoryList = await _categoryRepository.getCategoryList();
  }

  /// Load all transactions from the selected month.
  Future<void> loadTransactions() async {
    emit(TransactionsLoading(getMonthFormatted()));

    try {
      List<TransactionData> _dataset = await _transactionRepository.getTransactionsFromMonth(_monthSelected);
      emit(TransactionsLoaded(getMonthFormatted(), _dataset));
    } on Exception catch (error) {
      //TODO: logError(error)
      emit(TransactionsError(getMonthFormatted()));
    }
  }

  /// Get the category with id == [categoryId].
  CategoryData getCategory(int categoryId) => _categoryList.firstWhere((element) => element.id == categoryId);

  void setPreviousMonth() {
    _monthSelected = DateTime(_monthSelected.year, _monthSelected.month - 1, _monthSelected.day);
    loadTransactions();
  }

  void setNextMonth() {
    _monthSelected = DateTime(_monthSelected.year, _monthSelected.month + 1, _monthSelected.day);
    loadTransactions();
  }

  String getMonthFormatted() => DateFormat.yM().format(_monthSelected);
}
