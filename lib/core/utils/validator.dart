class InputValidator {
  static String? isNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "این فیلد نمیتواند خالی باشد";
    }
    return null;
  }
}
