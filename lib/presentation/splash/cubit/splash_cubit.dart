import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:organeasy/data/model/category_data.dart';
import 'package:organeasy/data/model/goal_data.dart';
import 'package:organeasy/data/model/monthly_balance_data.dart';
import 'package:organeasy/data/model/transaction_data.dart';
import 'package:organeasy/data/model/transaction_type.dart';
import 'package:organeasy/internal/simple_bloc_observer.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading()) {
    loadResources();
  }

  Future<void> loadResources() async {
    // load database
    await Hive.initFlutter("organeasy.db");
    Hive.registerAdapter(TransactionDataAdapter());
    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.registerAdapter(GoalDataAdapter());
    Hive.registerAdapter(CategoryDataAdapter());
    Hive.registerAdapter(MonthlyBalanceDataAdapter());

    // load locale files
    Intl.defaultLocale = "pt_BR";
    await initializeDateFormatting();

    if (kDebugMode) {
      Bloc.observer = SimpleBlocObserver();
    }

    emit(SplashLoaded());
  }
}
