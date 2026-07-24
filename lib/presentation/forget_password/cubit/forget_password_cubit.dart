import 'dart:async';
import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';
import 'package:exam_mobile_app/domain/use_case/forget_password_use_case.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/api_results.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final SharedPreferences _prefs;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordCubit(this._forgetPasswordUseCase, this._prefs)
    : super(ForgetPasswordState());

  final StreamController<ForgetPasswordUIEvents> _uiController = StreamController.broadcast();
  Stream<ForgetPasswordUIEvents> get uiStream => _uiController.stream;

  Future<void> doIntent(ForgetPasswordEvents forgetPasswordEvent) async {
    switch (forgetPasswordEvent) {
      case CheckEmailEvent():
        await _checkEmail(forgetPasswordEvent);
      case FormValidityChanged():
        emit(state.copyWith(isFormValid: forgetPasswordEvent.isFormValid));
    }
  }

  Future<void> _checkEmail(CheckEmailEvent event) async {
    var forgetPassword = await _forgetPasswordUseCase.call(event.email);
    switch (forgetPassword) {
      case Success<UserEntity>():
        {
          emit(state.copyWith(email: event.email));
          await _prefs.setString(email, event.email);
          _uiController.add(NavigateToVerifyEmail());
        }
      case Failure<UserEntity>():
        {
          _uiController.add(ShowSnackBar(forgetPassword.message!));
        }
    }
  }
}