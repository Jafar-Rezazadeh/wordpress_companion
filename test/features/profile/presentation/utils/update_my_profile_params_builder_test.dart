import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

void main() {
  test("should set the properties and build (UpdateMyParams) base on it", () {
    //arrange
    final builder = UpdateMyProfileParamsBuilder();

    //act
    builder
      ..setName("test")
      ..setFirstName("test")
      ..setLastName("test")
      ..setEmail("test")
      ..setUrl("test")
      ..setDescription("test")
      ..setNickname("test")
      ..setSlug("test");

    final result = builder.build();

    //assert
    expect(result, isA<UpdateMyProfileParams>());
    expect(result.name, "test");
    expect(result.firstName, "test");
    expect(result.lastName, "test");
    expect(result.email, "test");
    expect(result.url, "test");
    expect(result.description, "test");
    expect(result.nickName, "test");
    expect(result.slug, "test");
  });

  test("should throw an (AssertionError) when email field is Not Set", () {
    //arrange
    final builder = UpdateMyProfileParamsBuilder();

    //assert
    expect(() => builder.build(), throwsAssertionError);
  });
  test("should throw (AssertionError) when email field set to empty String",
      () {
    //arrange
    final builder = UpdateMyProfileParamsBuilder();

    //act
    builder.setEmail("");

    //assert
    expect(() => builder.build(), throwsAssertionError);
  });

  test("should set all the properties using the given initial object", () {
    //arrange
    final profile = ProfileEntity(
      id: 0,
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
      avatarUrls: const ProfileAvatarUrlsEntity(
        size24px: "size24px",
        size48px: "size48px",
        size96px: "size96px",
      ),
      roles: const [],
    );
    final builder = UpdateMyProfileParamsBuilder();

    //act
    builder.setFromInitialData(profile);

    //assert
    expect(builder.build(), isA<UpdateMyProfileParams>());
    expect(builder.build().name, profile.name);
    expect(builder.build().firstName, profile.firstName);
    expect(builder.build().lastName, profile.lastName);
    expect(builder.build().email, profile.email);
    expect(builder.build().url, profile.url);
    expect(builder.build().description, profile.description);
    expect(builder.build().nickName, profile.nickName);
    expect(builder.build().slug, profile.slug);
  });
}
