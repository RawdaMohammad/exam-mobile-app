import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/presentation/sign_up_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool hiddenPassword = false;
  bool isFormValid = false;
  bool rememberMe = false;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void checkFormValidity() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(tr("login.appBar")),
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
                      if (value == null || value.trim().isEmpty) {
                        return tr("login.emailRequired");
                      }

                      if (!emailRegex.hasMatch(value.trim())) {
                        return tr("login.invalidEmail");
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextFormField(
                    controller: passwordController,
                    obscureText: hiddenPassword,
                    labelText: tr("login.password"),
                    hintText: tr("login.enterPassword"),
                    onChanged: (_) => checkFormValidity(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hiddenPassword = !hiddenPassword;
                        });
                      },
                      icon: Icon(
                        hiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(
                        tr("login.rememberMe"),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Navigate to Forget Password screen
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          tr("login.forgetPassword"),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 81, 97, 109),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  CustomButton(
                    isNotDisabled: isFormValid,
                    buttonLabel: 'Login',
                    onPressedAction: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(text: tr("login.dontHaveAccount")),
                        TextSpan(
                          text: tr("login.signUpLine"),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 32, 62, 197),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpView(),
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
  }
}
