import 'package:injectable/injectable.dart';
import '../../core/network/api_results.dart';
import '../entities/user_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo _repository;

  VerifyResetCodeUseCase(this._repository);

  Future<ApiResults<UserEntity>> call(String? resetCode) {
    return _repository.verifyResetCode(resetCode);
  }
}