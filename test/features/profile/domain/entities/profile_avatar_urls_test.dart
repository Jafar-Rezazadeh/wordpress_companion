import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_avatar_urls.dart';

void main() {
  test("should add the expected fields to props ", () {
    //arrange

    ProfileAvatarUrlsEntity profileAvatarUrls = const ProfileAvatarUrlsEntity(
      size24px: "url1",
      size48px: "url2",
      size96px: "url3",
    );
    //act
    final result = profileAvatarUrls.props;
    //assert
    expect(result, ["url1", "url2", "url3"]);
  });

  test("should both be same if both has the same field values ", () {
    //arrange
    ProfileAvatarUrlsEntity object1 = const ProfileAvatarUrlsEntity(
      size24px: "url1",
      size48px: "url2",
      size96px: "url3",
    );
    ProfileAvatarUrlsEntity object2 = const ProfileAvatarUrlsEntity(
      size24px: "url1",
      size48px: "url2",
      size96px: "url3",
    );

    //assert
    expect(object1, object2);
  });
}
