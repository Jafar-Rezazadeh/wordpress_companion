import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/media/data/models/media_details_model.dart';

import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should convert json to (MediaDetailsModel)", () {
      //arrange
      final json = JsonResponseSimulator.media["media_details"];

      //act
      final result = MediaDetailsModel.fromJson(json);

      //assert
      expect(result, isA<MediaDetailsModel>());
    });

    test("should has the correct values ", () {
      //arrange
      final json = {
        "filesize": 114,
        "height": 100,
        "width": 100,
        "sizes": {},
      };

      //act
      final model = MediaDetailsModel.fromJson(json);

      //assert
      expect(model.fileSize, 114);
      expect(model.height, 100);
      expect(model.width, 100);
    });

    test("should height and width be null if not included in json ", () {
      //arrange
      final json = {
        "filesize": 114,
        "sizes": {},
      };

      //act
      final model = MediaDetailsModel.fromJson(json);

      //assert
      expect(model.fileSize, 114);
      expect(model.height, null);
      expect(model.width, null);
    });
  });
}
