class StringFormatter {
  static shortenText(String text, int maxLength) {
    if (text.length > maxLength) {
      return "${text.substring(0, maxLength)}...";
    } else {
      return text;
    }
  }
}
