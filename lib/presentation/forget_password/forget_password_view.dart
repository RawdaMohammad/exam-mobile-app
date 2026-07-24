import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_state.dart';
import 'package:exam_mobile_app/presentation/forget_password/verification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/signup_validators.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final ForgetPasswordCubit forgetPasswordCubit = getIt();
  late final StreamSubscription<ForgetPasswordUIEvents> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = forgetPasswordCubit.uiStream.listen((event) {
      switch (event) {
        case NavigateToVerifyEmail():
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerificationView()),
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
    _subscription.cancel();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: forgetPasswordCubit,
      child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              title: Text(
                tr("passwordAppBar"),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              leadingWidth: 25,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          tr("forgetPassword.title"),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr("forgetPassword.description"),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        AppTextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: tr("forgetPassword.emailLabel"),
                          hintText: tr("forgetPassword.emailHint"),
                          onChanged: (_) {
                            forgetPasswordCubit.doIntent(
                              FormValidityChanged(
                                _formKey.currentState?.validate() ?? false,
                              ),
                            );
                          },
                          validator: SignupValidators.email,
                        ),
                        const SizedBox(height: 48),
                        CustomButton(
                          isNotDisabled: state.isFormValid,
                          buttonLabel: tr("forgetPassword.continueButton"),
                          onPressedAction: () {
                            forgetPasswordCubit.doIntent(
                              CheckEmailEvent(_emailController.text.trim()),
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