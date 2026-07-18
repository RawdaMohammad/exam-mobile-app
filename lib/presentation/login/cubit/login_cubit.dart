import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/use_case/login_use_case.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_events.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginState.initial());

  final LoginUseCase _loginUseCase;

  final StreamController<LoginUIEvents> _uiController =
      StreamController.broadcast();

  Stream<LoginUIEvents> get uiStream => _uiController.stream;

  Future<void> doIntent(LoginEvents event) async {
    switch (event) {
      case LoginSubmitted():
        await _login(event);
      case TogglePasswordVisibility():
        emit(state.copyWith(obscurePassword: !state.obscurePassword));

      case RememberMeChanged():
        emit(state.copyWith(rememberMe: event.value));

      case FormValidityChanged():
        emit(state.copyWith(isFormValid: event.isValid));
    }
  }

  Future<void> _login(LoginSubmitted event) async {
    emit(state.copyWith(login: Resources.loading()));

    final result = await _loginUseCase.call(
      UserEntity(email: event.email, password: event.password),
      state.rememberMe,
    );

    switch (result) {
      case Success<UserEntity>():
        emit(state.copyWith(login: Resources.success(data: result.data)));
        _uiController.add(ShowMessage(tr("login.loginSuccessful")));

      case Failure<UserEntity>():
        emit(
          state.copyWith(
            login: Resources.error(
              message: result.message,
              exception: result.error?.exception,
            ),
          ),
        );
        _uiController.add(
          ShowMessage(result.message ?? tr("login.loginFailed")),
        );
    }
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}
