import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/core/network/safe_call.dart';
import 'package:exam_mobile_app/data/datasource/contract/auth_remote_datasource.dart';
import 'package:exam_mobile_app/data/mapper/auth_mapper.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource datasource;
  final AuthMapper mapper;
  final SharedPreferences sharedPreferences;

  AuthRepoImpl(this.datasource, this.mapper, this.sharedPreferences);

  @override
  Future<ApiResults<UserEntity>> login(UserEntity login, bool rememberMe) {
    return safeCall(() async {
      final response = await datasource.login(login.email, login.password);
      await sharedPreferences.setBool(rememberMeKey, rememberMe);

      if (rememberMe) {
        await sharedPreferences.setString(tokenKey, response.token ?? "");
      } else {
        await sharedPreferences.setString(tokenKey, "");
        debugPrint("Token: ${response.token}");
        
      }
      return Success(mapper.toEntity(response));
    });
  }

  @override
  Future<ApiResults<UserEntity>> signUp(SignUpRequest user) {
    return safeCall(() async {
      final response = await datasource.signUp(user);
      return Success(mapper.toEntity(response));
    });
  }
}
