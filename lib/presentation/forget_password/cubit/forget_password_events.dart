sealed class ForgetPasswordEvents {}

class CheckEmailEvent extends ForgetPasswordEvents {
  final String email;
  CheckEmailEvent(this.email);
}

class VerifyResetCodeEvent extends ForgetPasswordEvents {
  final String resetCode;
  VerifyResetCodeEvent(this.resetCode);
}

class ResetPasswordEvent extends ForgetPasswordEvents {
  final String newPassword;
  ResetPasswordEvent(this.newPassword);
}

class ResendResetCodeEvent extends ForgetPasswordEvents {}

class PasswordChangedEvent extends ForgetPasswordEvents {
  final String password;
  PasswordChangedEvent(this.password);
}

class FormValidityChanged extends ForgetPasswordEvents {
  final bool isFormValid;
  FormValidityChanged(this.isFormValid);
}

sealed class ForgetPasswordUIEvents {}

class NavigateToVerification extends ForgetPasswordUIEvents {}

class NavigateToResetPassword extends ForgetPasswordUIEvents {}

class NavigateToHome extends ForgetPasswordUIEvents {}

class ShowSnackBar extends ForgetPasswordUIEvents {
  final String message;
  ShowSnackBar(this.message);
}