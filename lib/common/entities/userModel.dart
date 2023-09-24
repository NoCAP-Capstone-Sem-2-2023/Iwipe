class UserModel {
  final String avatar;
  final String type;
  final String openId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserModel({
    required this.avatar,
    required this.type,
    required this.openId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'type': type,
      'openId': openId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}
