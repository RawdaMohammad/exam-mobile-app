import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/utils/password_validator.dart';

import 'regex_patterns.dart';

class SignupValidators {
  SignupValidators._();

  static String? userName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr("signup.userNameRequired");
    }

    return null;
  }

  static String? firstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr("signup.firstNameRequired");
    }

    return null;
  }

  static String? lastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr("signup.lastNameRequired");
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr("signup.emailRequired");
    }

    if (!RegexPatterns.email.hasMatch(value.trim())) {
      return tr("signup.invalidEmail");
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr("signup.phoneNumberRequired");
    }

    if (!RegexPatterns.egyptPhone.hasMatch(value.trim())) {
      return tr("signup.invalidPhoneNumber");
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return tr("signup.passwordRequired");
    }

    if (!PasswordValidator.isValid(value)) {
      return tr("signup.invalidPassword");
    }

    return null;
  }

  static String? confirmPassword(
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return tr("signup.confirmPasswordRequired");
    }

    if (value != password) {
      return tr("signup.passwordNotMatch");
    }

    return null;
  }
}