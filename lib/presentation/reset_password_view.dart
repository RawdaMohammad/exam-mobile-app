import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/utils/signup_validators.dart';
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../core/utils/password_validator.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isInfoValid = false;
  bool _isNewPassHidden = true, _isConfirmPassHidden = true;
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialCharacter = false;
  bool showPasswordRules = false;
  void checkFormValidity() {
    setState(() {
      _isInfoValid = _formKey.currentState?.validate() ?? false;
    });
  }
  void validatePassword(String password) {
    setState(() {
      showPasswordRules = password.isNotEmpty;
      hasMinLength = PasswordValidator.hasMinLength(password);
      hasUpperCase = PasswordValidator.hasUpperCase(password);
      hasLowerCase = PasswordValidator.hasLowerCase(password);
      hasNumber = PasswordValidator.hasNumber(password);
      hasSpecialCharacter = PasswordValidator.hasSpecialCharacter(password);
    });

    checkFormValidity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text(tr("passwordAppBar"), style: Theme.of(context).textTheme.titleMedium,),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              Text(tr("resetPassword.title"), style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 16,),
              Text(tr("resetPassword.description"), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                textAlign: TextAlign.center,),
              const SizedBox(height: 32,),
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
                      _isNewPassHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                validator: SignupValidators.password,
                obscureText: _isNewPassHidden,
                onChanged: (value) {
                  validatePassword(value);
                },
              ),
              const SizedBox(height: 25,),
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
                    _isConfirmPassHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) => SignupValidators.confirmPassword(value, _newPasswordController.text),
                obscureText: _isConfirmPassHidden,
              ),
              const SizedBox(height: 48,),
              CustomButton(
                isNotDisabled: _isInfoValid,
                buttonLabel: tr("forgetPassword.continueButton"),
                onPressedAction:  () {
                 // ToDo
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}