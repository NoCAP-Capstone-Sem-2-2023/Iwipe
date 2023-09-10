abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;

  const RegisterUsernameChanged(this.username);
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged( this.email);

}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged( this.password);

}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;

  const RegisterConfirmPasswordChanged( this.confirmPassword);
}


