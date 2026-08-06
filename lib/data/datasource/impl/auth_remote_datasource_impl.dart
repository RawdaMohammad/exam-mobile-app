import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/datasource/contract/auth_remote_datasource.dart';
import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/data/request/forget_password_request.dart';
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
  Future<UserResponse> forgotPassword(ForgetPasswordRequest request) {
    return apiClient.forgetPassword(request);
  }

  @override
  Future<UserResponse> resetPassword(ForgetPasswordRequest request) {
    return apiClient.resetPassword(request);
  }

  @override
  Future<UserResponse> verifyResetCode(ForgetPasswordRequest request) {
    return apiClient.verifyResetCode(request);
  }
}