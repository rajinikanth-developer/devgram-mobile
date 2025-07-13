import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? dob;

  @HiveField(4)
  final int? age;

  @HiveField(5)
  final String? password;

  @HiveField(6)
  bool isLoggedIn = false;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.dob,
    this.age,
    this.password,
    required this.isLoggedIn,
  });

  // Convert UserModel to UserEntity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      dob: dob,
      age: age,
      password: password ?? '',
      isLoggedIn: isLoggedIn,
    );
  }

  // Factory method to create UserModel from UserEntity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      dob: entity.dob,
      age: entity.age,
      password: entity.password,
      isLoggedIn: entity.isLoggedIn,
    );
  }
}
