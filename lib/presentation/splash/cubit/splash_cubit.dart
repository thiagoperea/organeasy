import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading()) {
    loadResources();
  }

  Future<void> loadResources() async {
    await Future.delayed(const Duration(seconds: 3));

    emit(SplashLoaded());
  }
}
