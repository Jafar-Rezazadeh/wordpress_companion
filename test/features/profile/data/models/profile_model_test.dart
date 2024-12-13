import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../../../dummy_stuff.dart';
import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should convert json to ProfileModel when success", () {
      //act
      final result = ProfileModel.fromJson(JsonResponseSimulator.profile);

      //assert
      expect(result, isA<ProfileModel>());
    });

    test("should converts field correctly related to given json", () {
      //arrange
      final json = JsonResponseSimulator.profile;

      //act
      final model = ProfileModel.fromJson(json);

      //assert
      _expectModelEqualsToJson(model, json);
    });

    test(
        "should all field has default values when json field is not there or value is null",
        () {
      //arrange
      final json = JsonResponseSimulator.profile;
      json.updateAll(
        (key, value) {
          return key == "avatar_urls"
              ? value = {"24": null, "48": null, "96": null}
              : value = null;
        },
      );

      //act
      final model = ProfileModel.fromJson(json);

      //assert
      expect(model, isA<ProfileModel>());
    });
  });

  group("toJson -", () {
    test("should return (Map<String, dynamic>)", () {
      //arrange
      final model = ProfileModel.fromJson(JsonResponseSimulator.profile);

      //act
      final result = model.toJson();

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });

    test("should include the blow fields", () {
      //arrange
      final model = ProfileModel.fromJson(JsonResponseSimulator.profile);

      //act
      final json = model.toJson();

      //assert
      final keysToCheck = [
        "name",
        "first_name",
        "last_name",
        "email",
        "url",
        "description",
        "nickname",
        "slug",
      ];

      for (var key in keysToCheck) {
        expect(json.keys, contains(key));
      }
    });

    test("should Not include below field ", () {
      //arrange
      final model = ProfileModel.fromJson(JsonResponseSimulator.profile);

      //act
      final json = model.toJson();

      //assert
      final keysToCheck = [
        "id",
        "username",
        "link",
        "locale",
        "registered_date",
        "avatar_urls",
        "roles",
      ];
      for (var key in keysToCheck) {
        expect(json.keys, isNot(contains(key)));
      }
    });

    test("should have the correct values", () {
      //arrange
      final model = ProfileModel.fromJson(JsonResponseSimulator.profile);

      //act
      final json = model.toJson();

      //assert
      _expectJsonEqualsToModel(json, model);
    });
  });

  group("toJsonFromParams -", () {
    test("should return (Map<String, dynamic>)", () {
      //arrange
      final params = DummyParams.updateMyProfileParams;

      //act
      final result = ProfileModel.toJsonFromParams(params);

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });
    test("should have the correct values", () {
      //arrange
      final params = DummyParams.updateMyProfileParams;

      //act
      final result = ProfileModel.toJsonFromParams(params);

      //assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result["name"], params.name);
      expect(result["first_name"], params.firstName);
      expect(result["last_name"], params.lastName);
      expect(result["email"], params.email);
      expect(result["nickname"], params.nickName);
      expect(result["slug"], params.slug);
      expect(result["description"], params.description);
      expect(result["url"], params.url);
    });
  });
}

void _expectModelEqualsToJson(
  ProfileModel model,
  Map<String, dynamic> json,
) {
  expect(model.id, json["id"]);
  expect(model.userName, json["username"]);
  expect(model.name, json["name"]);
  expect(model.firstName, json["first_name"]);
  expect(model.lastName, json["last_name"]);
  expect(model.email, json["email"]);
  expect(model.url, json["url"]);
  expect(model.description, json["description"]);
  expect(model.link, json["link"]);
  expect(model.locale, json["locale"]);
  expect(model.nickName, json["nickname"]);
  expect(model.slug, json["slug"]);
  expect(model.registeredDate, DateTime.parse(json["registered_date"]));
  expect(model.avatarUrls.size24px, json["avatar_urls"]["24"]);
  expect(model.avatarUrls.size48px, json["avatar_urls"]["48"]);
  expect(model.avatarUrls.size96px, json["avatar_urls"]["96"]);
  expect(model.roles.first.name, json["roles"][0]);
}

void _expectJsonEqualsToModel(Map<String, dynamic> json, ProfileModel model) {
  expect(json["name"], model.name);
  expect(json["first_name"], model.firstName);
  expect(json["last_name"], model.lastName);
  expect(json["email"], model.email);
  expect(json["url"], model.url);
  expect(json["description"], model.description);
  expect(json["nickname"], model.nickName);
  expect(json["slug"], model.slug);
}
