import '../../core/network/api_results.dart';
import '../entities/user_entity.dart';
import '../repo/auth_repo.dart';

class SignUseCase {
  final AuthRepo _repository;

  SignUseCase(this._repository);

  Future<ApiResults<UserEntity>> call(UserEntity user) {
    return _repository.signUp(user);
  }
}