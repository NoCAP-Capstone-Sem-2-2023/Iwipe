import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwipe/app_events.dart';
import 'package:iwipe/app_states.dart';

class AppBlocs extends Bloc<AppEvents, AppStates> {
  AppBlocs() : super(InitStates()) {
    on<IncrementEvent>((event, emit) {
      emit(AppStates(counter: state.counter + 1));
    });
  }
}
