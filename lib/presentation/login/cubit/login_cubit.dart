import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/use_case/login_use_case.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginState.initial());

  final LoginUseCase _loginUseCase;

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(login: Resources.loading()));

    final result = await _loginUseCase.call(
      UserEntity(email: email, password: password),
      state.rememberMe,
    );

    switch (result) {
      case Success<UserEntity>():
        emit(state.copyWith(login: Resources.success(data: result.data)));

      case Failure<UserEntity>():
        emit(
          state.copyWith(
            login: Resources.error(
              message: result.message,
              exception: result.error?.exception,
            ),
          ),
        );
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void updateRememberMe(bool value) async{
    emit(state.copyWith(rememberMe: value));
  }

  void updateFormValidity(bool isValid) {
    emit(state.copyWith(isFormValid: isValid));
  }
}
