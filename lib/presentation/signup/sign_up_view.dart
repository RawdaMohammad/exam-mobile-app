import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/utils/signup_validators.dart';
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/core/widgets/password_validation_support_text.dart';
import 'package:exam_mobile_app/data/request/sign_up_request.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_cubit.dart';
import 'package:exam_mobile_app/presentation/login/login_view.dart';
import 'package:exam_mobile_app/presentation/signup/cubit/sign_up_cubit.dart';
import 'package:exam_mobile_app/presentation/signup/cubit/sign_up_events.dart';
import 'package:exam_mobile_app/presentation/signup/cubit/sign_up_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late SignUpCubit signUpCubit;
  late final StreamSubscription<SignUpUIEvents> _subscription;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void checkFormValidity() {
    context.read<SignUpCubit>().doIntent(
      FormValidityChanged(_formKey.currentState?.validate() ?? false),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    for (final controller in [
      userNameController,
      firstNameController,
      lastNameController,
      emailController,
      passwordController,
      confirmPasswordController,
      phoneController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      signUpCubit = context.read<SignUpCubit>();

      _subscription = signUpCubit.uiStream.listen((event) {
        switch (event) {
          case SignupShowMessage():
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(event.message)));

            if (event.message == tr("signup.accountCreatedSuccessfully")) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => getIt<LoginCubit>(),
                    child: const LoginView(),
                  ),
                ),
              );
            }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 25,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              tr("signup.SignUpAppBar"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
                      AppTextFormField(
                        controller: userNameController,
                        labelText: "signup.userName".tr(),
                        hintText: "signup.enterUserName".tr(),
                        onChanged: (_) => checkFormValidity(),
                        validator: SignupValidators.userName,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                              controller: firstNameController,
                              keyboardType: TextInputType.name,
                              labelText: tr("signup.firstName"),
                              hintText: tr("signup.enterFirstName"),
                              onChanged: (_) => checkFormValidity(),
                              validator: SignupValidators.firstName,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: AppTextFormField(
                              controller: lastNameController,
                              keyboardType: TextInputType.name,
                              labelText: tr("signup.lastName"),
                              hintText: tr("signup.enterLastName"),
                              onChanged: (_) => checkFormValidity(),
                              validator: SignupValidators.lastName,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      AppTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: tr("signup.email"),
                        hintText: tr("signup.enterEmail"),
                        onChanged: (_) => checkFormValidity(),
                        validator: SignupValidators.email,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                              controller: passwordController,
                              obscureText: obscurePassword,
                              labelText: tr("signup.password"),
                              hintText: tr("signup.enterPassword"),
                              onChanged: (value) {
                                context.read<SignUpCubit>().doIntent(
                                  PasswordChanged(value),
                                );
                                checkFormValidity();
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 18,
                                ),
                              ),
                              validator: SignupValidators.password,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: AppTextFormField(
                              controller: confirmPasswordController,
                              obscureText: obscureConfirmPassword,
                              labelText: tr("signup.confirmPassword"),
                              hintText: tr("signup.enterConfirmPassword"),
                              onChanged: (_) => checkFormValidity(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureConfirmPassword =
                                        !obscureConfirmPassword;
                                  });
                                },
                                icon: Icon(
                                  obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 18,
                                ),
                              ),
                              validator: (value) =>
                                  SignupValidators.confirmPassword(
                                    value,
                                    passwordController.text,
                                  ),
                            ),
                          ),
                        ],
                      ),

                      if (state.showPasswordRules) ...[
                        const SizedBox(height: 10),

                        PasswordValidationSupportText(
                          title: tr("signup.passwordRules.minLength"),
                          valid: state.hasMinLength,
                        ),

                        PasswordValidationSupportText(
                          title: tr("signup.passwordRules.upperCase"),
                          valid: state.hasUpperCase,
                        ),

                        PasswordValidationSupportText(
                          title: tr("signup.passwordRules.lowerCase"),
                          valid: state.hasLowerCase,
                        ),

                        PasswordValidationSupportText(
                          title: tr("signup.passwordRules.number"),
                          valid: state.hasNumber,
                        ),

                        PasswordValidationSupportText(
                          title: tr("signup.passwordRules.specialCharacter"),
                          valid: state.hasSpecialCharacter,
                        ),
                      ],
                      SizedBox(height: 20),
                      AppTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: tr("signup.phoneNumber"),
                        hintText: tr("signup.enterPhoneNumber"),
                        onChanged: (_) => checkFormValidity(),
                        validator: SignupValidators.phone,
                      ),
                      SizedBox(height: 70),
                      CustomButton(
                        isNotDisabled: state.isFormValid,
                        buttonLabel: tr("signup.signupButton"),
                        onPressedAction: () {
                          if (!_formKey.currentState!.validate()) return;

                          context.read<SignUpCubit>().doIntent(
                            SignUpSubmitted(
                              SignUpRequest(
                                username: userNameController.text.trim(),
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                rePassword: confirmPasswordController.text
                                    .trim(),
                                phone: phoneController.text.trim(),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(text: tr("signup.alreadyHaveAccount")),
                            TextSpan(
                              text: tr("signup.loginLine"),
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider(
                                        create: (_) => getIt<LoginCubit>(),
                                        child: const LoginView(),
                                      ),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
