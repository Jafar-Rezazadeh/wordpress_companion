import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/media/data/models/media_model.dart';
import 'package:wordpress_companion/features/media/domain/use_cases/update_media.dart';

import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should return (MediaModel) when called with valid json", () {
      //arrange
      final json = JsonResponseSimulator.media;

      //act
      final result = MediaModel.fromJson(json);

      //assert
      expect(result, isA<MediaModel>());
    });

    test("should has the expected values when converted to model ", () {
      //arrange
      final json = JsonResponseSimulator.media;

      //act
      final model = MediaModel.fromJson(json);

      //assert
      _expectEqual(model, json);
    });
  });

  group("toJson -", () {
    test("should convert the model to (Map<String, dynamic>) ", () {
      //arrange
      final model = MediaModel.fromJson(JsonResponseSimulator.media);

      //act
      final json = model.toJson();

      //assert
      expect(json, isA<Map<String, dynamic>>());
    });

    test("should only include the expected field ", () {
      //arrange
      final model = MediaModel.fromJson(JsonResponseSimulator.media);

      //act
      final json = model.toJson();

      //assert
      expect(
        json.keys,
        containsAll(["alt_text", "caption", "title", "description"]),
      );
      expect(json.keys.length, 4);
    });
  });

  group("fromParamsToJson -", () {
    test("should return (Map<String, dynamic>)", () {
      //arrange
      const params = UpdateMediaParams(
        id: 0,
        altText: "altText",
        title: "title",
        caption: "caption",
        description: "description",
      );

      //act
      final result = MediaModel.fromParamsToJson(params);

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });
    test("should include the expected fields to (Map<String, dynamic>)", () {
      //arrange
      const params = UpdateMediaParams(
        id: 0,
        altText: "altText",
        title: "title",
        caption: "caption",
        description: "description",
      );

      //act
      final result = MediaModel.fromParamsToJson(params);

      //assert
      expect(result, isA<Map<String, dynamic>>());
      expect(
        result.keys,
        containsAll(["alt_text", "caption", "title", "description"]),
      );
      expect(result.keys.length, 4);
    });
  });
}

void _expectEqual(MediaModel model, Map<String, dynamic> json) {
  expect(model.id, json["id"]);
  expect(model.date, DateTime.parse(json["date"]));
  expect(model.guid, json["guid"]["raw"]);
  expect(model.modified, DateTime.parse(json["modified"]));
  expect(model.slug, json["slug"]);
  expect(model.status, json["status"]);
  expect(model.type, json["type"]);
  expect(model.link, json["link"]);
  expect(model.title, json["title"]["raw"]);
  expect(model.author, json["author"]);
  expect(model.featuredMedia, json["featured_media"]);
  expect(model.commentStatus, json["comment_status"]);
  expect(model.pingStatus, json["ping_status"]);
  expect(model.template, json["template"]);
  expect(model.permalinkTemplate, json["permalink_template"]);
  expect(model.generatedSlug, json["generated_slug"]);
  expect(model.classList.length, json["class_list"].length);
  expect(model.description, json["description"]["raw"]);
  expect(model.caption, json["caption"]["raw"]);
  expect(model.altText, json["alt_text"]);
  expect(model.mediaType, json["media_type"]);
  expect(model.mimeType, json["mime_type"]);
  expect(model.mediaDetails.fileSize, json["media_details"]["filesize"]);
  expect(model.post, json["post"]);
  expect(model.sourceUrl, json["source_url"]);
  expect(model.authorName, json["_embedded"]["author"][0]["name"]);
}
