sealed class VerificationEvents {}

class CheckResetCodeEvent extends VerificationEvents {
  final String resetCode;
  CheckResetCodeEvent(this.resetCode);
}

class ResendResetCodeEvent extends VerificationEvents {}

sealed class VerificationUIEvents {}

class NavigateToResetPassword extends VerificationUIEvents{}

class ShowSnackBar  extends VerificationUIEvents {
  final String message;
  ShowSnackBar (this.message);
}