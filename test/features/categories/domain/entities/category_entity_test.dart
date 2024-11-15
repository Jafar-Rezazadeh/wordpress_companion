import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/categories/domain/entities/category_entity.dart';

void main() {
  test("should add id to props ", () {
    //arrange
    const category = CategoryEntity(
      id: 2,
      count: 3,
      description: "description",
      link: "link",
      name: "name",
      slug: "slug",
      parent: 6,
    );

    //act
    final props = category.props;

    //assert
    expect(props, [category.id]);
  });

  test("should be same if id is same ", () {
    //arrange
    const category1 = CategoryEntity(
      id: 2,
      count: 3,
      description: "description",
      link: "link",
      name: "name",
      slug: "slug",
      parent: 6,
    );
    const category2 = CategoryEntity(
      id: 2,
      count: 6,
      description: "test",
      link: "test",
      name: "test",
      slug: "test",
      parent: 9,
    );

    //assert
    expect(category1 == category2, true);
  });
}
