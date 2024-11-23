import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../../../json_response_simulator.dart';

void main() {
  group("fromJson -", () {
    test("should return (ProfileAvatarUrlsModel)", () {
      //arrange
      final json = JsonResponseSimulator.profile["avatar_urls"];

      //act
      final result = ProfileAvatarUrlsModel.fromJson(json);

      //assert
      expect(result, isA<ProfileAvatarUrlsModel>());
    });

    test("should model has correct values ", () {
      //arrange
      final json = JsonResponseSimulator.profile["avatar_urls"];

      //act
      final model = ProfileAvatarUrlsModel.fromJson(json);

      //assert
      expect(model.size24px, json["24"]);
      expect(model.size48px, json["48"]);
      expect(model.size96px, json["96"]);
    });
  });
}
