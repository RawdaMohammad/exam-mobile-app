import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';

class LoginState {
  final Resources<UserEntity> login;

  const LoginState({required this.login});

  factory LoginState.initial() {
    return LoginState(login: Resources.init());
  }

  LoginState copyWith({Resources<UserEntity>? login}) {
    return LoginState(login: login ?? this.login);
  }
}
