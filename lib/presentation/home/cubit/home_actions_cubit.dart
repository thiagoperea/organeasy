import 'package:bloc/bloc.dart';
import 'package:organeasy/presentation/home/cubit/home_actions_state.dart';

class HomeActionsCubit extends Cubit<HomeActionsState> {
  HomeActionsCubit() : super(HomeActionsState());

  void onActionMenuPressed(HomeActions action) => emit(HomeActionsState(action: action));
}
