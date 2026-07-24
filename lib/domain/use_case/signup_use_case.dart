import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import 'package:injectable/injectable.dart';

import '../../core/network/api_results.dart';
import '../entities/user_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class SignUpUseCase {
  final AuthRepo _repository;

  SignUpUseCase(this._repository);

  Future<ApiResults<UserEntity>> call(SignUpRequest user) {
    return _repository.signUp(user);
  }
}