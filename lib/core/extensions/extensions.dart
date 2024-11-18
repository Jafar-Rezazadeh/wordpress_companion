import '../constants/enums.dart';

extension MimeTypeExtension on MediaTypeEnum {
  String get translate {
    switch (this) {
      case MediaTypeEnum.image:
        return "تصویر";
      case MediaTypeEnum.video:
        return "ویدیو";
      case MediaTypeEnum.text:
        return "متن";
      case MediaTypeEnum.application:
        return "فایل";
      case MediaTypeEnum.audio:
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
