import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwipe/pages/App/bloc/appEvent.dart';
import 'package:iwipe/pages/App/bloc/appState.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<TriggerAppEvent>((event, emit) {
      emit(AppState(index: event.index));
    });
  }
}
