import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_ds.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await localDataSource.login(email, password);
    return user.toEntity();
  }

  @override
  Future<void> register(UserEntity user) async {
    await localDataSource.register(UserModel.fromEntity(user));
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await localDataSource.getCurrentUser();
    return user?.toEntity();
  }

  @override
  Future<void> logout() async {
    await localDataSource.logout();
  }
}
