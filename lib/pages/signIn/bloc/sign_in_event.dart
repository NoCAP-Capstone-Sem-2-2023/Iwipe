abstract class SignInEvent {
  const SignInEvent();
}

class SignInEmailChanged extends SignInEvent {
  final String email;
  const SignInEmailChanged(this.email);
}
class SignInPasswordChanged extends SignInEvent {
  final String password;
  const SignInPasswordChanged(this.password);
}

