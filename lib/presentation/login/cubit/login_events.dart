sealed class LoginEvents {}

class LoginSubmitted extends LoginEvents {
  final String email;
  final String password;
  LoginSubmitted({required this.email, required this.password});
}

class TogglePasswordVisibility extends LoginEvents {}

class RememberMeChanged extends LoginEvents {
  final bool value;
  RememberMeChanged(this.value);
}

class FormValidityChanged extends LoginEvents {
  final bool isValid;
  FormValidityChanged(this.isValid);
}

sealed class LoginUIEvents {}

class ShowMessage extends LoginUIEvents {
  String message;

  ShowMessage(this.message);
}
