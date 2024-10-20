class InputValidator {
  static String? isNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "این فیلد نمیتواند خالی باشد";
    }
    return null;
  }

  static String? isValidEmail(String? value) {
    return value != null && _hasCorrectSyntax(value)
        ? null
        : "این ایمیل معتبر نیست";
  }

  static bool _hasCorrectSyntax(String value) {
    return value.contains(
      RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ),
    );
  }
}
