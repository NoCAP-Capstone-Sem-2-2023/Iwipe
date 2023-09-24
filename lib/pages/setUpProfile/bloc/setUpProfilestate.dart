class SetUpProfileState {
  final String firstName;
  final String lastName;
  final String avt;

  const SetUpProfileState({
    this.firstName="",
    this.lastName="",
    this.avt="",
  });

  SetUpProfileState copyWith({
    String? firstName,
    String? lastName,
    String? avt,
  }) {
    return SetUpProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avt: avt ?? this.avt,
    );
  }
}
