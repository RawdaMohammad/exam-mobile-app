import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/utils/signup_validators.dart';
import 'package:exam_mobile_app/core/utils/password_validator.dart';
import 'package:exam_mobile_app/core/widgets/app_text_form_field.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/core/widgets/custom_password_rule.dart';
import 'package:exam_mobile_app/presentation/login_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isFormValid = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void checkFormValidity() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialCharacter = false;
  bool showPasswordRules = false;
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
  void dispose() {
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
        title: Text(
          tr("signup.SignUpAppBar"),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight(500)),
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
                          obscureText: hidePassword,
                          labelText: tr("signup.password"),
                          hintText: tr("signup.enterPassword"),
                          onChanged: (value) {
                            validatePassword(value);
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                          obscureText: hideConfirmPassword,
                          labelText: tr("signup.confirmPassword"),
                          hintText: tr("signup.enterConfirmPassword"),
                          onChanged: (_) => checkFormValidity(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword = !hideConfirmPassword;
                              });
                            },
                            icon: Icon(
                              hideConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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

                  if (showPasswordRules) ...[
                    const SizedBox(height: 10),

                    PasswordRule(
                      title: "At least 8 characters",
                      valid: hasMinLength,
                    ),

                    PasswordRule(
                      title: "Contains an uppercase letter",
                      valid: hasUpperCase,
                    ),

                    PasswordRule(
                      title: "Contains a lowercase letter",
                      valid: hasLowerCase,
                    ),

                    PasswordRule(title: "Contains a number", valid: hasNumber),

                    PasswordRule(
                      title: "Contains a special character",
                      valid: hasSpecialCharacter,
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
                    isNotDisabled: isFormValid,
                    buttonLabel: tr("signup.signupButton"),
                    onPressedAction: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(text: tr("signup.alreadyHaveAccount")),
                        TextSpan(
                          text: tr("signup.loginLine"),
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
                                  builder: (_) => const LoginView(),
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
