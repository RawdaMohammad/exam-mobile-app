import 'package:exam_mobile_app/data/request/sign_up_request.dart';

sealed class SignUpEvents {}

class SignUpSubmitted extends SignUpEvents {
  final SignUpRequest request;

  SignUpSubmitted(this.request);
}

class FormValidityChanged extends SignUpEvents {
  final bool isValid;

  FormValidityChanged(this.isValid);
}

class PasswordChanged extends SignUpEvents {
  final String password;

  PasswordChanged(this.password);
}

sealed class SignUpUIEvents {}

class SignupShowMessage extends SignUpUIEvents {
  String message;

  SignupShowMessage(this.message);
}
