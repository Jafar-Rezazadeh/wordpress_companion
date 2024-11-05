import '../constants/enums.dart';

extension MimeTypeExtension on MediaType {
  String get translate {
    switch (this) {
      case MediaType.image:
        return "تصویر";
      case MediaType.video:
        return "ویدیو";
      case MediaType.text:
        return "متن";
      case MediaType.application:
        return "فایل";
      case MediaType.audio:
        return "صدا";
    }
  }
}

// TODO: add this to flutter handy util an extension
extension StringCustomExtension on String {
  String ellipsSize({required int maxLength, bool fromStart = false}) {
    if (length > maxLength) {
      if (fromStart) {
        return "...${substring(length - maxLength)}";
      }
      return "${substring(0, maxLength)}...";
    } else {
      return this;
    }
  }
}
