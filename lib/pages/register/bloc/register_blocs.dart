import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:iwipe/pages/register/bloc/register_event.dart';
import 'package:iwipe/pages/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }

  void _onUsernameChanged(RegisterUsernameChanged event, Emitter<RegisterState> emit) {
    print("${event.username}");
    emit(state.copyWith(username: event.username));

  }

  void _onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    print("${event.email}");

    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    print("${event.password}");
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(RegisterConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    print("${event.confirmPassword}");
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }
}
