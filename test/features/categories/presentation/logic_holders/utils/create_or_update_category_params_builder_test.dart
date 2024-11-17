import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

void main() {
  test("should return (CreateOrUpdateCategoryParams) when build method invoked",
      () {
    //arrange
    final builder = CreateOrUpdateCategoryParamsBuilder();

    //act
    final result = builder.build();

    //assert
    expect(result, isA<CreateOrUpdateCategoryParams>());
  });

  test("should set the values to params", () {
    //arrange
    final builder = CreateOrUpdateCategoryParamsBuilder();

    //act
    builder
      ..setName("test")
      ..setDescription("test")
      ..setParent(3)
      ..setSlug("slug");
    final params = builder.build();

    //assert
    expect(params.name, "test");
    expect(params.description, "test");
    expect(params.parent, 3);
    expect(params.slug, "slug");
  });

  test("should set initial values form a (CategoryEntity) ", () {
    //arrange
    const category = CategoryEntity(
      id: 2,
      count: 3,
      description: "description",
      link: "link",
      name: "name",
      slug: "slug",
      parent: 9,
    );
    final builder = CreateOrUpdateCategoryParamsBuilder();

    //act
    builder.setInitValues(category);

    final params = builder.build();

    //assert
    expect(params.id, category.id);
    expect(params.name, category.name);
    expect(params.description, category.description);
    expect(params.slug, category.slug);
    expect(params.parent, category.parent);
  });
}
