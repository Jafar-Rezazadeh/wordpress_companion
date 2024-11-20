import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/tags/data/models/tag_model.dart';

import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should convert to (TagModel) ", () {
      //arrange
      final json = JsonResponseSimulator.tag;

      //act
      final result = TagModel.fromJson(json);

      //assert
      expect(result, isA<TagModel>());
    });

    test("should have correct values ", () {
      //arrange
      final json = JsonResponseSimulator.tag;

      //act
      final model = TagModel.fromJson(json);

      //assert
      expect(model.id, json["id"]);
      expect(model.count, json["count"]);
      expect(model.name, json["name"]);
      expect(model.slug, json["slug"]);
      expect(model.description, json["description"]);
    });
  });

  group("fromParamsToJson", () {
    test("should return (Map<String,dynamic>) with expected values", () {
      //act
      final result = TagModel.fromParamsToJson("test name");

      //assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result["name"], "test name");
    });
  });
}
