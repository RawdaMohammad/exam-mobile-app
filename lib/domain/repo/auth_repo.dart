import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';

abstract class AuthRepo {

  Future<ApiResults<UserEntity>> login(
      UserEntity login,
      );

  Future<ApiResults<UserEntity>> signUp(SignUpRequest user);
}