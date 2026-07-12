import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepo _repository;

  LoginUseCase(this._repository);

  Future<ApiResults<UserEntity>> call(UserEntity login) {
    return _repository.login(login);
  }
}
