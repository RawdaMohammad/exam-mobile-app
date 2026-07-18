import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/utils/password_validator.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import 'package:exam_mobile_app/domain/use_case/signup_use_case.dart';
import 'package:exam_mobile_app/presentation/signup/cubit/sign_up_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signupUseCase) : super(SignUpState.initial());

  final SignupUseCase _signupUseCase;

  final StreamController<SignUpUIEvents> _uiController =
      StreamController.broadcast();

  Stream<SignUpUIEvents> get uiStream => _uiController.stream;

  Future<void> signUp(SignUpRequest user) async {
    emit(state.copyWith(signUp: Resources.loading()));

    final result = await _signupUseCase(user);

    switch (result) {
      case Success<UserEntity>():
        emit(state.copyWith(signUp: Resources.success(data: result.data)));
        _uiController.add(SignupShowMessage(tr("signup.accountCreatedSuccessfully")));

      case Failure<UserEntity>():
        emit(
          state.copyWith(
            signUp: Resources.error(
              message: result.message,
              exception: result.error?.exception,
            ),
          ),
        );
        _uiController.add(
          SignupShowMessage(result.message ?? tr("signup.somethingWentWrong")));
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void updateFormValidity(bool isValid) {
    emit(state.copyWith(isFormValid: isValid));
  }

  void validatePassword(String password) {
    emit(
      state.copyWith(
        showPasswordRules: password.isNotEmpty,
        hasMinLength: PasswordValidator.hasMinLength(password),
        hasUpperCase: PasswordValidator.hasUpperCase(password),
        hasLowerCase: PasswordValidator.hasLowerCase(password),
        hasNumber: PasswordValidator.hasNumber(password),
        hasSpecialCharacter: PasswordValidator.hasSpecialCharacter(password),
      ),
    );
  }
    @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}
