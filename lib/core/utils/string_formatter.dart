class StringFormatter {
  static shortenText(String text, int length) {
    if (text.length > length) {
      return "${text.substring(0, length)}...";
    } else {
      return text;
    }
  }
}
