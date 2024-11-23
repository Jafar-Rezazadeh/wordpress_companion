import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/tags/domain/entities/tag_entity.dart';

void main() {
  test("should include the (id) in props", () {
    //arrange
    const tag = TagEntity(
      id: 2,
      name: " name",
      slug: "slug",
      description: "description",
      count: 7,
    );

    //act
    final props = tag.props;

    //assert
    expect(props, [tag.id]);
  });
  test("should be two instance same if (id) of both in same ", () {
    //arrange
    const tag1 = TagEntity(
      id: 2,
      name: " name",
      slug: "slug",
      description: "description",
      count: 7,
    );
    const tag2 = TagEntity(
      id: 2,
      name: " name awd",
      slug: "slug562",
      description: "description awa",
      count: 9,
    );

    //assert
    expect(tag1 == tag2, true);
  });
}
