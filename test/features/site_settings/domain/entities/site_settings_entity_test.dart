import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/site_settings/domain/entities/site_settings_entity.dart';

void main() {
  const dummyEntity = SiteSettingsEntity(
    title: "title",
    description: "description",
    url: "url",
    email: "email",
    timeZone: "timeZone",
    dateFormat: "dateFormat",
    timeFormat: "timeFormat",
    startOfWeek: 1,
    language: "language",
    useSmilies: true,
    defaultCategory: 1,
    defaultPostFormat: "defaultPostFormat",
    postsPerPage: 0,
    showOnFront: "showOnFront",
    pageOnFront: 0,
    pageForPosts: 1,
    defaultPingStatus: "defaultPingStatus",
    defaultCommentStatus: "defaultCommentStatus",
    siteLogo: "siteLogo",
    siteIcon: 3,
  );
  test("should include the expected properties to props", () {
    //arrange
    const entity = dummyEntity;

    //act
    final props = entity.props;

    //assert
    expect(
      props,
      containsAll([
        entity.title,
        entity.description,
        entity.url,
        entity.email,
        entity.timeZone,
        entity.dateFormat,
        entity.timeFormat,
        entity.startOfWeek,
        entity.language,
        entity.siteIcon,
      ]),
    );
  });
  test("should objects with same properties be equal", () {
    //arrange
    const object1 = dummyEntity;
    const object2 = dummyEntity;

    //assert
    expect(object1 == object2, true);
  });
}
