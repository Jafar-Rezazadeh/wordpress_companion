import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_avatar_urls.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_entity.dart';

void main() {
  ProfileEntity makeInstanceWithId(int id) => ProfileEntity(
      id: id,
      userName: "userName",
      name: "name",
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      url: "url",
      description: "description",
      link: "link",
      locale: "locale",
      nickName: "nickName",
      slug: "slug",
      registeredDate: DateTime(1),
      roles: const [UserRole.administrator],
      avatarUrls: const ProfileAvatarUrlsEntity(
        size24px: "",
        size48px: "",
        size96px: "",
      ));

  test("should add the (id) when to props", () {
    //arrange

    ProfileEntity profileEntity = makeInstanceWithId(3);

    //act
    final result = profileEntity.props;

    //assert
    expect(result, [3]);
  });

  test("should be same if the (id) is same ", () {
    //arrange
    ProfileEntity object1 = makeInstanceWithId(3);
    ProfileEntity object2 = makeInstanceWithId(3);

    //assert
    expect(object1, object2);
  });
}
