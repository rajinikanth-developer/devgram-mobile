import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> register(UserEntity user);
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
}
