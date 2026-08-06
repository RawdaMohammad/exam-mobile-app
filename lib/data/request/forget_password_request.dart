class ForgetPasswordRequest {
  String? email;
  String? resetCode;
  String? newPassword;

  ForgetPasswordRequest({
    this.email,
    this.resetCode,
    this.newPassword
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (email != null) {
      data["email"] = email;
    }
    if (resetCode != null) {
      data["resetCode"] = resetCode;
    }
    if (newPassword != null) {
      data["newPassword"] = newPassword;
    }
    return data;
  }
}