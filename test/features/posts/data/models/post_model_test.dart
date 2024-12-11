import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/posts/data/models/post_model.dart';

import '../../../../dummy_stuff.dart';
import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should return (PostModel) when success", () {
      //arrange
      final json = JsonResponseSimulator.post;

      //act
      final result = PostModel.fromJson(json);

      //assert
      expect(result, isA<PostModel>());
    });

    test("should values be correct ", () {
      //arrange
      final json = JsonResponseSimulator.post;

      //act
      final model = PostModel.fromJson(json);

      //assert
      _expectFromJsonEqual(model, json);
    });
  });

  group("toJson -", () {
    test("should convert the model to(Map<String,dynamic>)", () {
      //arrange
      final model = PostModel.fromJson(JsonResponseSimulator.post);

      //act
      final result = model.toJson();

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });

    test("should contain the expected key ", () {
      //arrange
      final model = PostModel.fromJson(JsonResponseSimulator.post);

      //act
      final result = model.toJson();

      //assert
      final keys = [
        "title",
        "content",
        "slug",
        "status",
        "excerpt",
        "featured_media",
        "categories",
        "tags",
      ];

      for (var key in keys) {
        expect(result.keys, contains(key));
      }
    });

    test("should contain the expected values ", () {
      //arrange
      final model = PostModel.fromJson(JsonResponseSimulator.post);

      //act
      final result = model.toJson();

      //assert
      expect(result["title"], model.title);
      expect(result["content"], model.content);
      expect(result["slug"], model.slug);
      expect(result["status"], model.status.name);
      expect(result["excerpt"], model.excerpt);
      expect(result["featured_media"], model.featuredMedia);
      expect(result["categories"], model.categories);
      expect(result["tags"], model.tags);
    });

    test("should NOT contain the expected key", () {
      //arrange
      final model = PostModel.fromJson(JsonResponseSimulator.post);

      //act
      final result = model.toJson();

      //assert
      final keys = [
        "id",
        "date",
        "guid",
        "modified",
        "type",
        "link",
        "type",
        "author",
        "authorName",
        "featuredMediaLink",
        "comment_status",
      ];

      for (var key in keys) {
        expect(result.keys, isNot(contains(key)));
      }
    });
  });

  group("toJsonFromParams -", () {
    test("should converts PostParams to (Map<String,dynamic>) ", () {
      //arrange
      final postParams = DummyParams.postParams;

      //act
      final result = PostModel.toJsonFromParams(postParams);

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });
  });
}

_expectFromJsonEqual(PostModel model, Map<String, dynamic> json) {
  expect(model.id, json["id"]);
  expect(model.date, DateTime.parse(json["date"]));
  expect(model.modified, DateTime.parse(json["modified"]));
  expect(model.guid, json["guid"]["raw"]);
  expect(model.slug, json["slug"]);
  expect(model.status.name, json["status"]);
  expect(model.type, json["type"]);
  expect(model.link, json["link"]);
  expect(model.title, json["title"]["raw"]);
  expect(model.content, json["content"]["raw"]);
  expect(model.excerpt, json["excerpt"]["raw"]);
  expect(model.author, json["author"]);
  expect(model.authorName, json["_embedded"]["author"][0]["name"]);
  expect(model.featuredMedia, json["featured_media"]);
  expect(
    model.featureMediaLink,
    json["_embedded"]["wp:featuredmedia"][0]["source_url"],
  );
  expect(model.commentStatus, json["comment_status"]);
  expect(model.categories, json["categories"]);
  expect(model.tags, json["tags"]);
}
