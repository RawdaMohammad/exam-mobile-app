import 'package:exam_mobile_app/core/network/app_error.dart';

sealed class ApiResults<T>{
  String? message;
  T? data;
  AppError? error;

  ApiResults(this.message, this.data, this.error);
}

class Success<T> extends ApiResults<T>{
  Success(T? data) : super(null, data, null);
}

class Failure<T> extends ApiResults<T>{
  Failure(String? message, AppError? error) : super(message, null, error);
}