import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:iwipe/pages/setUpProfile/bloc/setUpProfileevent.dart';
import 'package:iwipe/pages/setUpProfile/bloc/setUpProfilestate.dart';
import 'package:meta/meta.dart';

import '../setUpProfile.dart';

class SetupProfileBloc extends Bloc<SetUpProfileEvent, SetUpProfileState> {
  SetupProfileBloc() : super(const SetUpProfileState()) {
    on<RegisterFirstnameChanged>(_onFirstNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterAVTChanged>(_onAVTChanged);
   }

  void _onFirstNameChanged(RegisterFirstnameChanged event, Emitter<SetUpProfileState> emit) {
    emit(state.copyWith(firstName: event.firstName));

  }

  void _onLastNameChanged(RegisterLastNameChanged event, Emitter<SetUpProfileState> emit) {

    emit(state.copyWith(lastName: event.lastName));
  }

  void _onAVTChanged(RegisterAVTChanged event, Emitter<SetUpProfileState> emit) {
    emit(state.copyWith(avt: event.avt));
  }
}
