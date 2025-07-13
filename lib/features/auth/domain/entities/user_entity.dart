class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? dob;
  final int? age;
  final String password;
  final bool isLoggedIn;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.dob,
    this.age,
    required this.password,
    required this.isLoggedIn,
  });
}
