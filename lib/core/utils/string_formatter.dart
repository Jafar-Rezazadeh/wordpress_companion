// TODO: add this to flutter handy util an extension
class StringFormatter {
  static shortenText(String text, int maxLength, {bool fromLast = false}) {
    if (text.length > maxLength) {
      if (fromLast) {
        return "${text.substring(text.length - maxLength)}...";
      }

      return "${text.substring(0, maxLength)}...";
    } else {
      return text;
    }
  }
}
