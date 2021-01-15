class Validator {
  static var emailValidatorRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /// Email Validate
  static bool validateEmail(String submittedValue) =>
      (emailValidatorRegExp.hasMatch(submittedValue));
}
