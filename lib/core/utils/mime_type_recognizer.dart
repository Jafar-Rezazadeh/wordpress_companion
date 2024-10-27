import '../constants/enums.dart';

class MimeTypeRecognizer {
  static MimeType fromString(String value) {
    if (value.contains("image")) {
      return MimeType.image;
    }
    if (value.contains("video")) {
      return MimeType.video;
    }
    return MimeType.file;
  }
}
