import 'dart:async';

import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:exam_mobile_app/domain/use_case/reset_password_use_case.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/reset_password_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/api_results.dart';
import '../../../core/utils/password_validator.dart';
import '../../../domain/entities/user_entity.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState>{
  final SharedPreferences _prefs;
  final ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordCubit(this._resetPasswordUseCase, this._prefs)
      : super(ResetPasswordState());

  final StreamController<ResetPasswordUIEvents> _uiController = StreamController.broadcast();
  Stream<ResetPasswordUIEvents> get uiStream => _uiController.stream;

  Future<void> doIntent(ResetPasswordEvents event) async{
    switch(event){
      case CheckResetPassword():
        await _checkResetPassword(event);
      case FormValidityChanged():
        emit(state.copyWith(isFormValid: event.isFormValid));
      case PasswordChanged():
        emit(
          state.copyWith(
            showPasswordRules: event.newPassword.isNotEmpty,
            hasMinLength: PasswordValidator.hasMinLength(event.newPassword),
            hasUpperCase: PasswordValidator.hasUpperCase(event.newPassword),
            hasLowerCase: PasswordValidator.hasLowerCase(event.newPassword),
            hasNumber: PasswordValidator.hasNumber(event.newPassword),
            hasSpecialCharacter: PasswordValidator.hasSpecialCharacter(
              event.newPassword,
            ),
          ),
        );
    }
  }

  Future<void> _checkResetPassword(CheckResetPassword event)async {
    var resetPassword = await _resetPasswordUseCase.call(_prefs.getString(email), event.newPassword);
    switch(resetPassword){
      case Success<UserEntity>():
        {
          emit(state.copyWith(newPassword: event.newPassword));
          _uiController.add(NavigateToHomeScreen());
        }
      case Failure<UserEntity>():
        {
          _uiController.add(ShowSnackBar(resetPassword.message!));
        }
    }
  }
}