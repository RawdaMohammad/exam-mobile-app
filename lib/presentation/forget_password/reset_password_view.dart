import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/utils/signup_validators.dart';
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/reset_password_cubit.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/reset_password_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/reset_password_state.dart';
import 'package:exam_mobile_app/presentation/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/password_validator.dart';
import '../login/cubit/login_cubit.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ResetPasswordCubit resetPasswordCubit = getIt();
  late final StreamSubscription<ResetPasswordUIEvents> _subscription;
  bool _isNewPassHidden = true, _isConfirmPassHidden = true;

  @override
  void initState() {
    super.initState();
    _subscription = resetPasswordCubit.uiStream.listen((event) {
      switch (event) {
        case NavigateToHomeScreen():
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => getIt<LoginCubit>(),
                child: const LoginView(),
              ),
            ),
          );
        case ShowSnackBar():
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(event.message)));
      }
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: resetPasswordCubit,
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              title: Text(
                tr("passwordAppBar"),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              titleSpacing: 0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          tr("resetPassword.title"),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr("resetPassword.description"),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        AppTextFormField(
                          controller: _newPasswordController,
                          labelText: "resetPassword.newPasswordLabel".tr(),
                          hintText: "resetPassword.newPasswordHint".tr(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isNewPassHidden = !_isNewPassHidden;
                              });
                            },
                            icon: Icon(
                              _isNewPassHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          validator: SignupValidators.password,
                          obscureText: _isNewPassHidden,
                          onChanged: (_) {
                            resetPasswordCubit.doIntent(
                              PasswordChanged(
                                _newPasswordController.text.trim(),
                              ),
                            );
                            resetPasswordCubit.doIntent(
                              FormValidityChanged(
                                _formKey.currentState?.validate() ?? false,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        AppTextFormField(
                          controller: _confirmPasswordController,
                          labelText: "resetPassword.confirmPasswordLabel".tr(),
                          hintText: "resetPassword.confirmPasswordHint".tr(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmPassHidden = !_isConfirmPassHidden;
                              });
                            },
                            icon: Icon(
                              _isConfirmPassHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          validator: (value) =>
                              SignupValidators.confirmPassword(
                                value,
                                _newPasswordController.text,
                              ),
                          obscureText: _isConfirmPassHidden,
                          onChanged: (_) {
                            resetPasswordCubit.doIntent(
                              FormValidityChanged(
                                _formKey.currentState?.validate() ?? false,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 48),
                        CustomButton(
                          isNotDisabled: state.isFormValid,
                          buttonLabel: tr("forgetPassword.continueButton"),
                          onPressedAction: () {
                            resetPasswordCubit.doIntent(
                              CheckResetPassword(
                                _newPasswordController.text.trim(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}