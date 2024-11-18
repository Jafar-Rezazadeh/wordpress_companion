import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should return (CategoryModel) from json ", () {
      //arrange
      final json = JsonResponseSimulator.category;

      //act
      final result = CategoryModel.fromJson(json);

      //assert
      expect(result, isA<CategoryModel>());
    });

    test("should return (CategoryModel) with correct values ", () {
      //arrange
      final json = JsonResponseSimulator.category;

      //act
      final model = CategoryModel.fromJson(json);

      //assert
      expect(model.id, json["id"]);
      expect(model.name, json["name"]);
      expect(model.slug, json["slug"]);
      expect(model.description, json["description"]);
      expect(model.link, json["link"]);
      expect(model.parent, json["parent"]);
      expect(model.count, json["count"]);
    });
  });

  group("toJson -", () {
    test("should convert model to (Map<String,dynamic>)", () {
      //arrange
      final model = CategoryModel.fromJson(JsonResponseSimulator.category);

      //act
      final result = model.toJson();

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });

    test("should contains the expected values ", () {
      //arrange
      final model = CategoryModel.fromJson(JsonResponseSimulator.category);

      //act
      final json = model.toJson();

      //assert
      expect(json["name"], model.name);
      expect(json["slug"], model.slug);
      expect(json["parent"], model.parent);
      expect(json["description"], model.description);
    });

    test("should Not include expected fields in json ", () {
      //arrange
      final model = CategoryModel.fromJson(JsonResponseSimulator.category);

      //act
      final json = model.toJson();

      //assert
      final unExceptedKeys = [
        "id",
        "count",
        "link",
      ];

      for (var key in unExceptedKeys) {
        expect(json.keys, isNot(contains(key)));
      }
    });
  });

  group("fromParamsToJson -", () {
    test(
        "should convert createOrUpdateCategoryParams to (Map<String,dynamic>) ",
        () {
      //arrange
      final params = CreateOrUpdateCategoryParams(
        id: 2,
        name: "name",
        slug: "slug",
        parent: 6,
        description: "description",
      );

      //act
      final result = CategoryModel.fromParamsToJson(params);

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });
  });
}
