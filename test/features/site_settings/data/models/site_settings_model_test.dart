import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should return (SiteSettingsModel) when success to convert from json",
        () {
      //arrange
      final json = JsonResponseSimulator.siteSettings;

      //act
      final result = SiteSettingsModel.fromJson(json);

      //assert
      expect(result, isA<SiteSettingsModel>());
    });

    test("should has correct values", () {
      //arrange
      final json = JsonResponseSimulator.siteSettings;

      //act
      final model = SiteSettingsModel.fromJson(json);

      //assert
      _expectModelEqualsJson(model, json);
    });
  });

  group("toJson -", () {
    test("should convert the model to json when success", () {
      //arrange
      final model = SiteSettingsModel.fromJson(
        JsonResponseSimulator.siteSettings,
      );

      //act
      final result = model.toJson();

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });

    test("should has the correct values when convert the model to json", () {
      //arrange
      final model = SiteSettingsModel.fromJson(
        JsonResponseSimulator.siteSettings,
      );

      //act
      final json = model.toJson();

      //assert
      expect(json["title"], model.title);
      expect(json["description"], model.description);
      expect(json["site_icon"], model.siteIcon);
      expect(json["url"], model.url);
      expect(json["email"], model.email);
      expect(json["language"], model.language);
      expect(json["timezone"], model.timeZone);
      expect(json["date_format"], model.dateFormat);
      expect(json["time_format"], model.timeFormat);
      expect(json["start_of_week"], model.startOfWeek);
    });

    test("should include the expected properties ", () {
      //arrange
      final model = SiteSettingsModel.fromJson(
        JsonResponseSimulator.siteSettings,
      );

      //act
      final json = model.toJson();

      //assert
      expect(
        json.keys,
        containsAll([
          "title",
          "description",
          "site_icon",
          "url",
          "email",
          "language",
          "timezone",
          "date_format",
          "time_format",
          "start_of_week",
        ]),
      );
    });

    test("should Not include the expected properties ", () {
      //arrange
      final model = SiteSettingsModel.fromJson(
        JsonResponseSimulator.siteSettings,
      );

      //act
      final json = model.toJson();

      //assert
      expect(
        json.keys,
        isNot(containsAll([
          "use_smilies",
          "default_category",
          "default_post_format",
          "posts_per_page",
          "show_on_front",
          "page_on_front",
          "page_for_posts",
          "default_ping_status",
          "default_comment_status",
          "site_logo",
        ])),
      );
    });
  });
}

void _expectModelEqualsJson(
    SiteSettingsModel model, Map<String, dynamic> json) {
  expect(model.title, json["title"]);
  expect(model.description, json["description"]);
  expect(model.url, json["url"]);
  expect(model.timeZone, json["timezone"]);
  expect(model.dateFormat, json["date_format"]);
  expect(model.timeFormat, json["time_format"]);
  expect(model.startOfWeek, json["start_of_week"]);
  expect(model.language, json["language"]);
  expect(model.useSmilies, json["use_smilies"]);
  expect(model.defaultCategory, json["default_category"]);
  expect(model.defaultPostFormat, json["default_post_format"]);
  expect(model.postsPerPage, json["posts_per_page"]);
  expect(model.showOnFront, json["show_on_front"]);
  expect(model.pageOnFront, json["page_on_front"]);
  expect(model.pageForPosts, json["page_for_posts"]);
  expect(model.defaultPingStatus, json["default_ping_status"]);
  expect(model.defaultCommentStatus, json["default_comment_status"]);
  expect(model.siteLogo, json["site_logo"]);
  expect(model.siteIcon, json["site_icon"]);
}
