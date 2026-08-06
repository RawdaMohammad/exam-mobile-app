import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordState extends Equatable {
  final String? email;
  final String? resetCode;
  final String? newPassword;
  final bool isLoading;
  final bool? isFormValid;
  final bool? showPasswordRules;
  final bool? hasMinLength;
  final bool? hasUpperCase;
  final bool? hasLowerCase;
  final bool? hasNumber;
  final bool? hasSpecialCharacter;

  const ForgetPasswordState({
    this.email,
    this.resetCode,
    this.newPassword,
    this.isLoading = false,
    this.isFormValid = false,
    this.showPasswordRules = false,
    this.hasMinLength = false,
    this.hasUpperCase = false,
    this.hasLowerCase = false,
    this.hasNumber = false,
    this.hasSpecialCharacter = false,
  });

  ForgetPasswordState copyWith({
    String? email,
    String? resetCode,
    String? newPassword,
    bool? isLoading,
    bool? isFormValid,
    bool? showPasswordRules,
    bool? hasMinLength,
    bool? hasUpperCase,
    bool? hasLowerCase,
    bool? hasNumber,
    bool? hasSpecialCharacter,
  }) {
    return ForgetPasswordState(
      email: email ?? this.email,
      resetCode: resetCode ?? this.resetCode,
      newPassword: newPassword ?? this.newPassword,
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      showPasswordRules: showPasswordRules ?? this.showPasswordRules,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUpperCase: hasUpperCase ?? this.hasUpperCase,
      hasLowerCase: hasLowerCase ?? this.hasLowerCase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecialCharacter: hasSpecialCharacter ?? this.hasSpecialCharacter,
    );
  }

  @override
  List<Object?> get props => [
    email,
    resetCode,
    newPassword,
    isLoading,
    isFormValid,
    showPasswordRules,
    hasMinLength,
    hasUpperCase,
    hasLowerCase,
    hasNumber,
    hasSpecialCharacter
  ];
}