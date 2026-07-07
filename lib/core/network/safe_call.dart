import 'dart:async';
import 'package:dio/dio.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/core/network/app_error.dart';

Future<ApiResults<T>> safeCall<T>(Future<ApiResults<T>> Function() call) async{
  try {
    return call();
  } catch (e) {
    var error = errorParser(e as Exception);
    return Failure(error.message, error);
  }
}

AppError errorParser(Exception exception){
  if(exception is DioException){
    switch(exception.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutAppError(exception, "Connection timed out. Please try again.");
      case DioExceptionType.badCertificate:
        return ForceLoginAppError(); // to send them to login page
      case DioExceptionType.badResponse:
        var message = (exception.response as Map<String, dynamic>)["message"];
        return BadResponseAppError(message?? "Something went wrong");
      case DioExceptionType.connectionError:
      return NoInternetAppError(
        "No internet connection. Please check your network.",
      );
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
      case DioExceptionType.transformTimeout:
        return IgnoreAppError();
    }
  }
  return IgnoreAppError();
}