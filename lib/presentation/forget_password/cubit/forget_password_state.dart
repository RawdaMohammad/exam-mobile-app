import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordState {
  final String? email;
  final bool isFormValid;
  const ForgetPasswordState({this.email, this.isFormValid = false});

  ForgetPasswordState copyWith({String? email, bool? isFormValid}) {
    return ForgetPasswordState(
      email: email ?? this.email,
      isFormValid: isFormValid ?? this.isFormValid
    );
  }
}