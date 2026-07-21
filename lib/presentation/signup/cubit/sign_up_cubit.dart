import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/utils/password_validator.dart';
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

  Future<void> doIntent(SignUpEvents event) async {
    switch (event) {
      case SignUpSubmitted():
        await _signUp(event);

      case FormValidityChanged():
        emit(state.copyWith(isFormValid: event.isValid));

      case PasswordChanged():
        emit(
          state.copyWith(
            showPasswordRules: event.password.isNotEmpty,
            hasMinLength: PasswordValidator.hasMinLength(event.password),
            hasUpperCase: PasswordValidator.hasUpperCase(event.password),
            hasLowerCase: PasswordValidator.hasLowerCase(event.password),
            hasNumber: PasswordValidator.hasNumber(event.password),
            hasSpecialCharacter: PasswordValidator.hasSpecialCharacter(
              event.password,
            ),
          ),
        );
    }
  }

  Future<void> _signUp(SignUpSubmitted event) async {
    emit(state.copyWith(signUp: Resources.loading()));

    final result = await _signupUseCase(event.request);

    switch (result) {
      case Success<UserEntity>():
        emit(state.copyWith(signUp: Resources.success(data: result.data)));
        _uiController.add(
          SignupShowMessage(tr("signup.accountCreatedSuccessfully")),
        );

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
          SignupShowMessage(result.message ?? tr("signup.somethingWentWrong")),
        );
    }
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}
