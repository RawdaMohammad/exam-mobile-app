import 'package:exam_mobile_app/data/models/user_response.dart';

abstract class AuthDatasource {
  Future<UserResponse> login(String? email, String? password);
}
