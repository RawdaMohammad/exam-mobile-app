import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authinterceptor implements Interceptor {
  final SharedPreferences sharedPreferences;
  Authinterceptor(this.sharedPreferences);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = sharedPreferences.getString("token");
    if (token != null && token.isNotEmpty) {
      options.headers["token"] = token;
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint("Status: ${response.statusCode}");
    handler.next(response);
  }
}
