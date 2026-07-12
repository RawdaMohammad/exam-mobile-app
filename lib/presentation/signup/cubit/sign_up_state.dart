import 'package:exam_mobile_app/core/base/resources.dart';
import 'package:exam_mobile_app/domain/entities/user_entity.dart';

class SignUpState {
  final Resources<UserEntity> signUp;

  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isFormValid;
  final bool showPasswordRules;
  final bool hasMinLength;
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumber;
  final bool hasSpecialCharacter;

  const SignUpState({
    required this.signUp,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.isFormValid,
    required this.showPasswordRules,
    required this.hasMinLength,
    required this.hasUpperCase,
    required this.hasLowerCase,
    required this.hasNumber,
    required this.hasSpecialCharacter,
  });

  factory SignUpState.initial() {
    return SignUpState(
      signUp: Resources.init(),
      obscurePassword: true,
      obscureConfirmPassword: true,
      isFormValid: false,
      showPasswordRules: false,
      hasMinLength: false,
      hasUpperCase: false,
      hasLowerCase: false,
      hasNumber: false,
      hasSpecialCharacter: false,
    );
  }

  SignUpState copyWith({
    Resources<UserEntity>? signUp,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? isFormValid,
    bool? showPasswordRules,
    bool? hasMinLength,
    bool? hasUpperCase,
    bool? hasLowerCase,
    bool? hasNumber,
    bool? hasSpecialCharacter,
  }) {
    return SignUpState(
      signUp: signUp ?? this.signUp,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
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
