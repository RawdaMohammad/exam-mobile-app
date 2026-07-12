import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';

class LoginState {
  final Resources<UserEntity> login;

  final bool obscurePassword;
  final bool rememberMe;
  final bool isFormValid;

  const LoginState({
    required this.login,
    required this.obscurePassword,
    required this.rememberMe,
    required this.isFormValid,
  });

  factory LoginState.initial() {
    return LoginState(
      login: Resources.init(),
      obscurePassword: true,
      rememberMe: false,
      isFormValid: false,
    );
  }

  LoginState copyWith({
    Resources<UserEntity>? login,
    bool? obscurePassword,
    bool? rememberMe,
    bool? isFormValid,
  }) {
    return LoginState(
      login: login ?? this.login,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
