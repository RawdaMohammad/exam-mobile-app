import 'package:dio/dio.dart';
import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../session/session_manager.dart';

@injectable
class AuthInterceptor implements Interceptor {
  final SharedPreferences sharedPreferences;
  final SessionManager sessionManager;
  AuthInterceptor(this.sharedPreferences, this.sessionManager);

  static const publicEndpoints = {
    "/api/v1/auth/signup",
    "/api/v1/auth/signin",
    "/api/v1/auth/forgotPassword",
    "/api/v1/auth/verifyResetCode",
    "/api/v1/auth/resetPassword",
  };

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler) async {
    String? token = sessionManager.token ??
        sharedPreferences.getString(tokenKey);
    if (!publicEndpoints.contains(options.path) &&
        token != null &&
        token.isNotEmpty) {
      options.headers[tokenKey] = token;
    }

    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler) {
    debugPrint("Status: ${response.statusCode}");
    handler.next(response);
  }
}