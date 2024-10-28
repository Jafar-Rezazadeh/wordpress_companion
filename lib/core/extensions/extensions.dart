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
