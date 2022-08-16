import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppLoadingState()) {
    on<CheckAppStateEvent>(_onCheckAppState);
  }

  Future<void> _onCheckAppState(
    CheckAppStateEvent event,
    Emitter<AppState> emit,
  ) async {
    // show home screen
    emit(const AppHomeState());
  }
}
