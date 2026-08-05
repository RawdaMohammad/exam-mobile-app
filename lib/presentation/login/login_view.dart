import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/core/di/di.dart' show getIt;
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/presentation/forget_password_view.dart';
import 'package:exam_mobile_app/presentation/home_view.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_cubit.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_events.dart';
import 'package:exam_mobile_app/presentation/login/cubit/login_state.dart';
import 'package:exam_mobile_app/presentation/signup/cubit/sign_up_cubit.dart';
import 'package:exam_mobile_app/presentation/signup/sign_up_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginCubit loginCubit;
  late final StreamSubscription<LoginUIEvents> _subscription;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;

  void checkFormValidity() {
    context.read<LoginCubit>().doIntent(
      FormValidityChanged(_formKey.currentState?.validate() ?? false),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginCubit = context.read<LoginCubit>();

      _subscription = loginCubit.uiStream.listen((event) {
        switch (event) {
          case ShowMessage():
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(event.message)));

            if (event.message == tr("login.loginSuccessful")) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeView()),
              );
            }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
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
              tr("login.appBar"),
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: tr("login.email"),
                        hintText: tr("login.enterEmail"),
                        onChanged: (_) => checkFormValidity(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("signup.passwordRequired");
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      AppTextFormField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        labelText: tr("login.password"),
                        hintText: tr("login.enterPassword"),
                        onChanged: (_) => checkFormValidity(),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("login.passwordRequired");
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: state.rememberMe,
                            onChanged: (value) {
                              context.read<LoginCubit>().doIntent(
                                RememberMeChanged(value ?? false),
                              );
                            },
                          ),
                          Text(
                            tr("login.rememberMe"),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgetPasswordView(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              tr("login.forgetPassword"),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 70),
                      CustomButton(
                        isNotDisabled:
                            state.isFormValid &&
                            state.login.status != Status.loading,
                        buttonLabel: tr("login.loginButton"),
                        onPressedAction: () {
                          if (!_formKey.currentState!.validate()) return;

                          context.read<LoginCubit>().doIntent(
                            LoginSubmitted(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(text: tr("login.dontHaveAccount")),
                            TextSpan(
                              text: tr("login.signUpLine"),
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
                                        create: (_) => getIt<SignUpCubit>(),
                                        child: const SignUpView(),
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
