import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading()) {
    loadResources();
  }

  Future<void> loadResources() async {
    // load database
    await Hive.initFlutter();

    // load locale files
    Intl.defaultLocale = "pt_BR";
    await initializeDateFormatting();

    emit(SplashLoaded());
  }
}
