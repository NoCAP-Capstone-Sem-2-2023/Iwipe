import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwipe/pages/profile/Settings/bloc/settingsEvent.dart';
import 'package:iwipe/pages/profile/Settings/bloc/settingsState.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsState> {
  SettingsBloc() :super(SettingsState()) {
    on<TriggerSettingsEvent>(_onTriggerSettingsEvent);
  }


  _onTriggerSettingsEvent(SettingsEvents event, Emitter<SettingsState> emit) {
    emit(SettingsState());
  }
}

