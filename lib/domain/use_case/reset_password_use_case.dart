import 'package:injectable/injectable.dart';
import '../../core/network/api_results.dart';
import '../entities/user_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _repository;

  ResetPasswordUseCase(this._repository);

  Future<ApiResults<UserEntity>> call(String? email, String? newPassword) {
    return _repository.resetPassword(email, newPassword);
  }
}