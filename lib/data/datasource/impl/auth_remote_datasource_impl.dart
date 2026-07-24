import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/datasource/contract/auth_remote_datasource.dart';
import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ExamApiClient apiClient;

  AuthRemoteDatasourceImpl(this.apiClient);

  @override
  Future<UserResponse> login(String? email, String? password) {
    return apiClient.login({"email": email, "password": password});
  }

  @override
  Future<UserResponse> signUp(SignUpRequest user) {
    return apiClient.signUp(user);
  }

  @override
  Future<UserResponse> forgotPassword(String? email) {
    return apiClient.forgetPassword({"email": email});
  }

  @override
  Future<UserResponse> resetPassword(String? email, String? newPassword) {
    return apiClient.resetPassword({"email": email, "newPassword": newPassword});
  }

  @override
  Future<UserResponse> verifyResetCode(String? resetCode) {
    return apiClient.verifyResetCode({"resetCode": resetCode});
  }
}