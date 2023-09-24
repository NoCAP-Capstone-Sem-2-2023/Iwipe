abstract class SetUpProfileEvent {
  const SetUpProfileEvent();
}

class RegisterFirstnameChanged extends SetUpProfileEvent {
  final String firstName;

  const RegisterFirstnameChanged(this.firstName);
}

class RegisterLastNameChanged extends SetUpProfileEvent {
  final String lastName;

  const RegisterLastNameChanged( this.lastName);

}

class RegisterAVTChanged extends SetUpProfileEvent {
  final String avt;

  const RegisterAVTChanged( this.avt);

}

