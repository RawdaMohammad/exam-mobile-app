import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordState {
  final String? newPassword;
  final bool isFormValid;
  final bool? showPasswordRules;
  final bool? hasMinLength;
  final bool? hasUpperCase;
  final bool? hasLowerCase;
  final bool? hasNumber;
  final bool? hasSpecialCharacter;

  const ResetPasswordState({
    this.newPassword,
    this.isFormValid = false,
    this.showPasswordRules = false,
    this.hasMinLength = false,
    this.hasUpperCase = false,
    this.hasLowerCase = false,
    this.hasNumber = false,
    this.hasSpecialCharacter = false,
  });

  ResetPasswordState copyWith({
    String? newPassword,
    bool? isFormValid,
    bool? showPasswordRules,
    bool? hasMinLength,
    bool? hasUpperCase,
    bool? hasLowerCase,
    bool? hasNumber,
    bool? hasSpecialCharacter
  }) {
    return ResetPasswordState(
      newPassword: newPassword ?? this.newPassword,
      isFormValid: isFormValid ?? this.isFormValid,
      showPasswordRules: showPasswordRules ?? this.showPasswordRules,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUpperCase: hasUpperCase ?? this.hasUpperCase,
      hasLowerCase: hasLowerCase ?? this.hasLowerCase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecialCharacter: hasSpecialCharacter ?? this.hasSpecialCharacter,
    );
  }
}