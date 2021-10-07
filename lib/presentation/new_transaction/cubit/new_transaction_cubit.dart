import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/goal_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/data/repository/category_repository.dart';
import 'package:organeasy/data/repository/goal_repository.dart';
import 'package:organeasy/data/repository/transaction_repository.dart';
import 'package:organeasy/internal/string_extensions.dart';

part 'new_transaction_state.dart';

class NewTransactionCubit extends Cubit<NewTransactionState> {

  final TransactionRepository _transactionRepository = TransactionRepository(); // TODO: DI
  final CategoryRepository _categoryRepository = CategoryRepository();
  final GoalRepository _goalRepository = GoalRepository();

  NewTransactionCubit() : super(LoadingScreen());

  final List<CategoryData> categoryList = List.empty(growable: true); // TODO: REMOVE
  final List<GoalData> goalsList = List.empty(growable: true); // TODO: REMOVE

  Future<void> loadScreen() async {
    emit(LoadingScreen());

    categoryList.addAll(await _categoryRepository.getCategoryList());

    goalsList.addAll(await _goalRepository.getGoalList());

    emit(ScreenLoaded());
  }

  Future<void> saveTransaction({
    required int transactionTypeId,
    required int categoryId,
    int? goalId,
    required String description,
    required String dueDate,
    required String totalValue,
    required bool isDone,
  }) async {
    emit(SavingTransaction());

    final transaction = TransactionData(
      walletId: 0, // ! TODO: will I control more than one wallet?
      transactionType: transactionTypeId,
      categoryId: categoryId,
      goalId: goalId,
      description: description,
      dueDate: DateFormat.yMd().parse(dueDate),
      value: StringExtensions.moneyToDouble(totalValue),
      isDone: isDone,
    );

    await _transactionRepository.addTransaction(transaction);

    emit(TransactionSaved());
  }
}
