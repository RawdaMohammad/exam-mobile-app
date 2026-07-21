class UserEntity {
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? rePassword;
  final String? phone;

  const UserEntity({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    required this.email,
    this.password,
    this.rePassword,
    this.phone,
  });
}
