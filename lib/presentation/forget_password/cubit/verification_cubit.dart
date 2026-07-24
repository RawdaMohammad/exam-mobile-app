import 'dart:async';
import 'package:exam_mobile_app/core/constants/storage_keys.dart';
import 'package:exam_mobile_app/domain/use_case/verify_reset_code_use_case.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/verification_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/verification_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/api_results.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_case/forget_password_use_case.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState>{
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final SharedPreferences _sharedPreferences;
  VerificationCubit(this._verifyResetCodeUseCase, this._forgetPasswordUseCase, this._sharedPreferences)
      : super(VerificationState());

  final StreamController<VerificationUIEvents> _uiController = StreamController.broadcast();
  Stream<VerificationUIEvents> get uiStream => _uiController.stream;

  Future<void> doIntent(VerificationEvents verificationEvent) async{
    switch(verificationEvent){
      case CheckResetCodeEvent():
        await _checkResetCode(verificationEvent);
      case ResendResetCodeEvent():
        await _resendResetCode();
    }
  }

  Future<void> _checkResetCode(CheckResetCodeEvent event)async {
    if (state.isLoading) return;
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
    var forgetPassword = await _forgetPasswordUseCase.call(_sharedPreferences.getString(email));
    switch (forgetPassword) {
      case Success<UserEntity>():
        {
          _uiController.add(ShowSnackBar("Send OTP"));

        }
      case Failure<UserEntity>():
        {
          _uiController.add(ShowSnackBar("Can't send OTP try again"));
        }
    }
    debugPrint(_sharedPreferences.getString(email));
  }
}