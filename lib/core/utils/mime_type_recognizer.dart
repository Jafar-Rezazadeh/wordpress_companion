import '../constants/enums.dart';

class MimeTypeRecognizer {
  static MimeTypeEnum fromString(String value) {
    if (value.contains("image")) {
      return MimeTypeEnum.image;
    }
    if (value.contains("video")) {
      return MimeTypeEnum.video;
    }
    return MimeTypeEnum.file;
  }
}
