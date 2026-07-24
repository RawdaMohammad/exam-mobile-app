sealed class ForgetPasswordEvents {}

class CheckEmailEvent extends ForgetPasswordEvents {
  final String email;
  CheckEmailEvent(this.email);
}

class FormValidityChanged extends ForgetPasswordEvents {
  final bool isFormValid;
  FormValidityChanged(this.isFormValid);
}

sealed class ForgetPasswordUIEvents {}

class NavigateToVerifyEmail extends ForgetPasswordUIEvents {}

class ShowSnackBar  extends ForgetPasswordUIEvents {
  final String message;
  ShowSnackBar (this.message);
}