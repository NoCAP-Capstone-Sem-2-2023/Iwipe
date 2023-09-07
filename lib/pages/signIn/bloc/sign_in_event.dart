part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {
  const SignInEvent();
}

class SignInEmailChanged extends SignInEvent {
  final String email;
  const SignInEmailChanged({required this.email});
}
class SignInPasswordChanged extends SignInEvent {
  final String password;
  const SignInPasswordChanged({required this.password});
}
