import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

void main() {
  test("should set the values to correct props ", () {
    //arrange
    final postsFilters = GetPostsFilters();

    //act
    postsFilters
      ..setSearch("test")
      ..setAfter("after")
      ..setBefore("before")
      ..setCategories([1, 2]);

    //assert
    expect(postsFilters.search, "test");
    expect(postsFilters.after, "after");
    expect(postsFilters.before, "before");
    expect(postsFilters.categories, [1, 2]);
  });

  test("should set all props to null when reset() invoked", () {
    //arrange
    final postsFilters = GetPostsFilters();

    //act
    postsFilters
      ..setSearch("test")
      ..setAfter("after")
      ..setBefore("before")
      ..setCategories([1, 2]);

    postsFilters.reset();

    //assert
    expect(postsFilters.search, null);
    expect(postsFilters.after, null);
    expect(postsFilters.before, null);
    expect(postsFilters.categories, null);
  });
}
