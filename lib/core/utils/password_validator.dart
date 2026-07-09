import 'regex_patterns.dart';

class PasswordValidator {
  PasswordValidator._();

  static bool hasMinLength(String password) =>
      password.length >= 8;

  static bool hasUpperCase(String password) =>
      RegexPatterns.upperCase.hasMatch(password);

  static bool hasLowerCase(String password) =>
      RegexPatterns.lowerCase.hasMatch(password);

  static bool hasNumber(String password) =>
      RegexPatterns.number.hasMatch(password);

  static bool hasSpecialCharacter(String password) =>
      RegexPatterns.special.hasMatch(password);

  static bool isValid(String password) {
    return hasMinLength(password) &&
        hasUpperCase(password) &&
        hasLowerCase(password) &&
        hasNumber(password) &&
        hasSpecialCharacter(password);
  }
}