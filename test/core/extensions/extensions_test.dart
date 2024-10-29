import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/extensions/extensions.dart';

void main() {
  group("translate -", () {
    test("should translate to expected string ", () {
      //arrange
      const image = MediaType.image;
      const video = MediaType.video;
      const audio = MediaType.audio;
      const text = MediaType.text;
      const application = MediaType.application;

      //assert
      expect(image.translate, "تصویر");
      expect(video.translate, "ویدیو");
      expect(audio.translate, "صدا");
      expect(text.translate, "متن");
      expect(application.translate, "فایل");
    });
  });
}
