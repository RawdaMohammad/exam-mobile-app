import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/datasource/contract/auth_datasource.dart';
import 'package:exam_mobile_app/data/models/user_response.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final ExamApiClient apiClient;

  AuthDatasourceImpl(this.apiClient);

  @override
  Future<UserResponse> login(String? email, String? password) {
    return apiClient.login({"email": email, "password": password});
  }

  @override
  Future<UserResponse> signUp(UserEntity user) {
    return apiClient.signUp(user);
  }
}
