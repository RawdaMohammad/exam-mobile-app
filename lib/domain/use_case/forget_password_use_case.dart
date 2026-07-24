import 'package:injectable/injectable.dart';

import '../../core/network/api_results.dart';
import '../entities/user_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _repository;

  ForgetPasswordUseCase(this._repository);

  Future<ApiResults<UserEntity>> call(String? email) {
    return _repository.forgotPassword(email);
  }
}