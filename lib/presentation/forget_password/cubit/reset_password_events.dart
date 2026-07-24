sealed class ResetPasswordEvents {}

class CheckResetPassword extends ResetPasswordEvents {
  final String newPassword;
  CheckResetPassword(this.newPassword);
}

class FormValidityChanged extends ResetPasswordEvents {
  final bool isFormValid;
  FormValidityChanged(this.isFormValid);
}

class PasswordChanged extends ResetPasswordEvents {
  final String newPassword;

  PasswordChanged(this.newPassword);
}

sealed class ResetPasswordUIEvents {}

class NavigateToHomeScreen extends ResetPasswordUIEvents{}

class ShowSnackBar  extends ResetPasswordUIEvents {
  final String message;
  ShowSnackBar (this.message);
}