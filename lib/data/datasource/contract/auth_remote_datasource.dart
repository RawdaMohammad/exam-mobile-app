import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import '../../request/forget_password_request.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserResponse> login(String? email, String? password);
  Future<UserResponse> signUp(SignUpRequest user);
  Future<UserResponse> forgotPassword(ForgetPasswordRequest request);
  Future<UserResponse> verifyResetCode(ForgetPasswordRequest request);
  Future<UserResponse> resetPassword(ForgetPasswordRequest request);
}