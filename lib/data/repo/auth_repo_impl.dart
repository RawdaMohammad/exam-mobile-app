import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/core/network/safe_call.dart';
import 'package:exam_mobile_app/data/datasource/contract/auth_remote_datasource.dart';
import 'package:exam_mobile_app/data/mapper/auth_mapper.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/session/session_manager.dart';
import '../models/user_response.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource remoteDatasource;
  final AuthMapper mapper;
  final SharedPreferences sharedPreferences;
  final SessionManager sessionManager;

  AuthRepoImpl(
    this.remoteDatasource,
    this.mapper,
    this.sharedPreferences,
    this.sessionManager,
  );

  @override
  Future<ApiResults<UserEntity>> login(UserEntity login, bool rememberMe) {
    return safeCall(() async {
      final response = await remoteDatasource.login(
        login.email,
        login.password,
      );
      await sharedPreferences.setBool(rememberMeKey, rememberMe);
      sessionManager.token = response.token;
      if (rememberMe) {
        await sharedPreferences.setString(tokenKey, response.token ?? "");
      } else {
        await sharedPreferences.setString(tokenKey, "");
      }
      return Success(mapper.toEntity(response));
    });
  }

  @override
  Future<ApiResults<UserEntity>> signUp(SignUpRequest user) {
    return safeCall(() async {
      final response = await remoteDatasource.signUp(user);
      return Success(mapper.toEntity(response));
    });
  }

  @override
  Future<ApiResults<UserEntity>> forgotPassword(String? email) {
    return safeCall(() async {
      final response = UserResponse(message: tr("forgetPassword.success"));
      await Future.delayed(const Duration(seconds: 2));
      return Success(mapper.toEntity(response));
    });
  }

  @override
  Future<ApiResults<UserEntity>> resetPassword(
    String? email,
    String? newPassword,
  ) {
    return safeCall(() async {
      final response = UserResponse(message: tr("resetPassword.success"));
      await Future.delayed(const Duration(seconds: 2));
      return Success(mapper.toEntity(response));
    });
  }

  @override
  Future<ApiResults<UserEntity>> verifyResetCode(String? resetCode) {
    return safeCall(() async {
      final response = UserResponse(message: tr("verification.success"));
      await Future.delayed(const Duration(seconds: 2));
      return Success(mapper.toEntity(response));
    });
  }
}
