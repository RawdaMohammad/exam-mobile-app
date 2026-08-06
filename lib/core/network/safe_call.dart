import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/core/network/app_error.dart';

Future<ApiResults<T>> safeCall<T>(Future<ApiResults<T>> Function() call) async {
  try {
    final result = await call();
    return result;
  } catch (e) {
    var error = errorParser(e as Exception);
    return Failure(error.message, error);
  }
}

AppError errorParser(Exception exception) {
  if (exception is DioException) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutAppError(exception, tr("errors.connectionTimeout"));
      case DioExceptionType.badCertificate:
        return ForceLoginAppError();
      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);
      case DioExceptionType.connectionError:
        return NoInternetAppError(tr("errors.noInternet"));
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
      case DioExceptionType.transformTimeout:
        return IgnoreAppError();
    }
  }
  return IgnoreAppError();
}

AppError _handleBadResponse(DioException exception) {
  final response = exception.response;
  final statusCode = response?.statusCode;

  String? serverMessage;

  final data = response?.data;

  if (data is Map<String, dynamic>) {
    serverMessage = data["message"]?.toString();
  }

  switch (statusCode) {
    case 400:
      return BadRequestAppError(serverMessage ?? tr("errors.badRequest"));

    case 401:
      final message = serverMessage?.toLowerCase() ?? "";

      if (serverMessage != null &&
          serverMessage.toLowerCase().contains("incorrect")) {
        return BadCredentialsAppError(null, serverMessage);
      }
      if (message.contains("must be a valid email") ||
          message.contains("fails to match the required pattern")) {
        return ValidationAppError(tr("errors.validation"));
      }
      return ForceLoginAppError();

    case 403:
      return ForbiddenAppError(serverMessage ?? tr("errors.forbidden"));

    case 404:
      return NotFoundAppError(serverMessage ?? tr("errors.notFound"));

    case 409:
      return ConflictAppError(serverMessage ?? tr("errors.conflict"));

    case 422:
      return ValidationAppError(serverMessage ?? tr("errors.validation"));

    case 429:
      return TooManyRequestsAppError(
        serverMessage ?? tr("errors.tooManyRequests"),
      );

    case 500:
      return ServerAppError(serverMessage ?? tr("errors.server"));

    case 502:
      return ServerAppError(serverMessage ?? tr("errors.badGateway"));

    case 503:
      return ServiceUnavailableAppError(
        serverMessage ?? tr("errors.serviceUnavailable"),
      );

    case 504:
      return ServerAppError(serverMessage ?? tr("errors.gatewayTimeout"));

    default:
      return UnknownAppError(serverMessage ?? tr("errors.unknown"));
  }
}