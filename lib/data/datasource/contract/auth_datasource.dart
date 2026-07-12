import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';

abstract class AuthDatasource {
  Future<UserResponse> login(String? email, String? password);
  Future<UserResponse> signUp(UserEntity user);
}
