import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/extensions/extensions.dart';

void main() {
  group("MimeTypeExtension -", () {
    group("translate -", () {
      test("should translate to expected string ", () {
        //arrange
        const image = MediaTypeEnum.image;
        const video = MediaTypeEnum.video;
        const audio = MediaTypeEnum.audio;
        const text = MediaTypeEnum.text;
        const application = MediaTypeEnum.application;

        //assert
        expect(image.translate, "تصویر");
        expect(video.translate, "ویدیو");
        expect(audio.translate, "صدا");
        expect(text.translate, "متن");
        expect(application.translate, "فایل");
      });
    });
  });

  group("StringCustomExtension -", () {
    group("ellipsSize", () {
      test("should return same string when length is less than maxLength", () {
        //arrange
        const text = "test";

        //act
        final result = text.ellipsSize(maxLength: 20);

        //assert
        expect(result, text);
      });

      test("should ellips string from start when fromStart is false", () {
        //arrange
        const text = "Irure consectetur nulla ex cillum anim sint aliqua.";

        //act
        final result = text.ellipsSize(maxLength: 10, fromStart: false);

        //assert
        expect(result, "${text.substring(0, 10)}...");
      });

      test("should ellips string from end when fromStart is true", () {
        //arrange
        const text = "Irure consectetur nulla ex cillum anim sint aliqua.";

        //act
        final result = text.ellipsSize(maxLength: 10, fromStart: true);

        //assert
        expect(result, "...${text.substring(text.length - 10)}");
      });
    });
  });
}
