import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/presentation/verification_view.dart';
import 'package:flutter/material.dart';

import '../core/utils/signup_validators.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  bool _isEmailValid = false;
  String? _errorText;
  void checkValidity() {
    setState(() {
      _isEmailValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text(tr("passwordAppBar"), style: Theme.of(context).textTheme.titleLarge,),
        leadingWidth: 25,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text(tr("forgetPassword.title"), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16,),
                Text(tr("forgetPassword.description"),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                  textAlign: TextAlign.center,),
                const SizedBox(height: 32,),

                AppTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: tr("forgetPassword.emailLabel"),
                  hintText: tr("forgetPassword.emailHint"),
                  onChanged: (_) => checkValidity(),
                  validator: SignupValidators.email,
                ),
                const SizedBox(height: 48,),
                CustomButton(
                  isNotDisabled: _isEmailValid,
                  buttonLabel: tr("forgetPassword.continueButton"),
                  onPressedAction:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerificationView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}