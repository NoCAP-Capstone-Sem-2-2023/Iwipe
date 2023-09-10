class RegisterState {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterState({
    this.username="",
    this.email="",
    this.password="",
    this.confirmPassword="",
  });

  RegisterState copyWith({
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
