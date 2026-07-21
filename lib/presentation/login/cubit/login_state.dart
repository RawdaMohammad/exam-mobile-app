import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';

class LoginState {
  final Resources<UserEntity> login;
  final bool rememberMe;
  final bool isFormValid;

  const LoginState({
    required this.login,
    required this.rememberMe,
    required this.isFormValid,
  });

  LoginState.initial()
    : this(login: Resources.init(), rememberMe: false, isFormValid: false);

  LoginState copyWith({
    Resources<UserEntity>? login,
    bool? rememberMe,
    bool? isFormValid,
  }) {
    return LoginState(
      login: login ?? this.login,
      rememberMe: rememberMe ?? this.rememberMe,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
