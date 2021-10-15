import 'package:bloc/bloc.dart';
import 'package:organeasy/presentation/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void onActionMenuPressed(HomeActions action) => emit(HomeActionMenuPressed(action));
}
