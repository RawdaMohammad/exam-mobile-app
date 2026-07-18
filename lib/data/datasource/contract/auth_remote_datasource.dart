import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';

abstract class AuthRemoteDatasource {
  Future<UserResponse> login(String? email, String? password);
  Future<UserResponse> signUp(SignUpRequest user);
}
