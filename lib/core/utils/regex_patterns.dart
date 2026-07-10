class RegexPatterns {
  RegexPatterns._();

  static final email = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  static final egyptPhone = RegExp(
    r'^01[0125][0-9]{8}$',
  );

  static final upperCase = RegExp(r'[A-Z]');
  static final lowerCase = RegExp(r'[a-z]');
  static final number = RegExp(r'[0-9]');
  static final special =
      RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
}