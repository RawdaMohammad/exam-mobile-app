abstract class AppError {
  Exception? exception;
  String? message;
  AppError(this.exception, this.message);
}

class TimeoutAppError extends AppError{
  TimeoutAppError(super.exception, super.message);
}

class BadCredentialsAppError extends AppError{
  BadCredentialsAppError(super.exception, super.message);
}

class ServerAppError extends AppError{
  ServerAppError(super.exception, super.message);
}

class IgnoreAppError extends AppError{
  IgnoreAppError(): super(null, null);
}

class ForceLoginAppError extends AppError{
  ForceLoginAppError(): super(null, null);
}

class BadResponseAppError extends AppError{
  BadResponseAppError(String message): super(null, message);
}

class NoInternetAppError extends AppError{
  NoInternetAppError(String message): super(null, message);
}