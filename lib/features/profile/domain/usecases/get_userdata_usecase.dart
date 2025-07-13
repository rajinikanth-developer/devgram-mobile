import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class GetUserdataUsecase {
  final AuthRepository repository;

  GetUserdataUsecase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getCurrentUser();
  }
}
