import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/use_case/forget_password_use_case.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/network/api_results.dart';
import '../../../core/utils/password_validator.dart';
import '../../../domain/use_case/reset_password_use_case.dart';
import '../../../domain/use_case/verify_reset_code_use_case.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit(
      this._forgetPasswordUseCase,
      this._verifyResetCodeUseCase,
      this._resetPasswordUseCase,
      ):super(const ForgetPasswordState());

  final _uiController = StreamController<ForgetPasswordUIEvents>.broadcast();

  Stream<ForgetPasswordUIEvents> get uiStream => _uiController.stream;

  Future<void> doIntent(ForgetPasswordEvents event) async {
    switch (event) {
      case CheckEmailEvent():
        await _checkEmail(event);
      case VerifyResetCodeEvent():
        await _checkResetCode(event);
      case ResetPasswordEvent():
        await _checkResetPassword(event);
      case ResendResetCodeEvent():
        await _resendResetCode();
      case PasswordChangedEvent():
        _checkPasswordChanged();
      case FormValidityChanged():
        emit(state.copyWith(isFormValid: event.isFormValid));
    }
  }

  Future<void> _checkEmail(CheckEmailEvent event) async {
    emit(state.copyWith(isLoading: true));
    var forgetPassword = await _forgetPasswordUseCase.call(event.email);
    switch (forgetPassword) {
      case Success<UserEntity>():
        {
          emit(state.copyWith(email: event.email, isLoading: false));
          _uiController.add(NavigateToVerification());
        }
      case Failure<UserEntity>():
        {
          emit(state.copyWith(isLoading: false));
          _uiController.add(ShowSnackBar(forgetPassword.message!));
        }
    }
  }

  Future<void> _checkResetCode(VerifyResetCodeEvent event)async {
    emit(state.copyWith(isLoading: true));
    var verifyResetCode = await _verifyResetCodeUseCase.call(event.resetCode);
    switch(verifyResetCode){
      case Success<UserEntity>():
        {
          emit(state.copyWith(resetCode: event.resetCode, isLoading: false));
          _uiController.add(NavigateToResetPassword());
        }
      case Failure<UserEntity>():
        {
          emit(state.copyWith(resetCode: "", isLoading: false));
        }
    }
  }

  Future<void> _resendResetCode()async {
    emit(state.copyWith(resetCode: ""));
    var forgetPassword = await _forgetPasswordUseCase.call(state.email);
    switch (forgetPassword) {
      case Success<UserEntity>():
        {
          _uiController.add(ShowSnackBar(tr("messages.otpSent")));

        }
      case Failure<UserEntity>():
        {
          _uiController.add(ShowSnackBar(tr("messages.errorSentOtp")));
        }
    }
  }

  Future<void> _checkResetPassword(ResetPasswordEvent event)async {
    emit(state.copyWith(isLoading: true, newPassword: event.newPassword));
    var resetPassword = await _resetPasswordUseCase.call(state.email, event.newPassword);
    switch(resetPassword){
      case Success<UserEntity>():
        {
          emit(state.copyWith(newPassword: event.newPassword, isLoading: false));
          _uiController.add(NavigateToHome());
        }
      case Failure<UserEntity>():
        {
          emit(state.copyWith(isLoading: false));
          _uiController.add(ShowSnackBar(resetPassword.message!));
        }
    }
  }

  void _checkPasswordChanged(){
    emit(
      state.copyWith(
        newPassword: state.newPassword,
        showPasswordRules: state.newPassword?.isNotEmpty,
        hasMinLength: PasswordValidator.hasMinLength(state.newPassword!),
        hasUpperCase: PasswordValidator.hasUpperCase(state.newPassword!),
        hasLowerCase: PasswordValidator.hasLowerCase(state.newPassword!),
        hasNumber: PasswordValidator.hasNumber(state.newPassword!),
        hasSpecialCharacter: PasswordValidator.hasSpecialCharacter(
          state.newPassword!,
        ),
      ),
    );
  }
}