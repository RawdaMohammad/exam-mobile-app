sealed class SignUpEvents{}

sealed class SignUpUIEvents{}

class SignupShowMessage extends SignUpUIEvents {
  String message;

  SignupShowMessage(this.message);
}