import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/utils/mime_type_recognizer.dart';

void main() {
  group("fromString -", () {
    test("should return expected MimeType enum by given String", () {
      //arrange
      final image = MimeTypeRecognizer.fromString("image/jpeg");
      final video = MimeTypeRecognizer.fromString("video/mp4");

      //assert
      expect(image, MimeType.image);
      expect(video, MimeType.video);
    });

    test("should return file when not recognized by given String", () {
      //arrange
      final file = MimeTypeRecognizer.fromString("file");

      //assert
      expect(file, MimeType.file);
    });
  });
}
