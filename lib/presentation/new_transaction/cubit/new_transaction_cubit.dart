import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/goal_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/internal/string_extensions.dart';

part 'new_transaction_state.dart';

class NewTransactionCubit extends Cubit<NewTransactionState> {
  NewTransactionCubit() : super(LoadingScreen());

  final _categoryList = [
    CategoryData(id: 0, description: "Receitas"),
    CategoryData(id: 1, description: "Aposentadoria"),
    CategoryData(id: 2, description: "Reserva de Emergência"),
    CategoryData(id: 3, description: "Necessidades"),
    CategoryData(id: 4, description: "Lazer"),
    CategoryData(id: 5, description: "Doação"),
    CategoryData(id: 1337, description: "Objetivos"),
  ];

  final _goalsList = [
    GoalData(id: 0, description: "Casa", dueDate: DateTime.now(), goalValue: 20000.00, currentValue: 500.00),
    GoalData(id: 1, description: "Carro", dueDate: DateTime.now(), goalValue: 1000.00, currentValue: 700.00),
    GoalData(id: 2, description: "Computador", dueDate: DateTime.now(), goalValue: 5000.00, currentValue: 1500.00),
  ];

  Future<void> loadScreen() async {
    emit(LoadingScreen());

    // ! TODO: get category list from repository
    await Future.delayed(Duration(seconds: 1));

    // ! TODO: get goals list from repository
    await Future.delayed(Duration(seconds: 1));

    emit(ScreenLoaded());
  }

  List<CategoryData> getCategoryList() => _categoryList;

  List<GoalData> getGoalList() => _goalsList;

  void saveTransaction({
    required int transactionTypeId,
    required int categoryId,
    int? goalId,
    required String description,
    required String dueDate,
    required String totalValue,
    required bool isDone,
  }) {
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
  }
}
