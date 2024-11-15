import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class FakePostEntity extends Fake implements PostEntity {
  @override
  int get id => 1;

  @override
  String get title => "title";

  @override
  String get slug => "SLUG";

  @override
  PostStatus get status => PostStatus.future;

  @override
  String get content => "content";

  @override
  String get excerpt => "excerpt";

  @override
  List<int> get categories => [1, 5, 6];

  @override
  List<int> get tags => [9, 8, 6];

  @override
  int get featuredMedia => 2;
}

void main() {
  test("should return PostParams when build is called", () {
    //arrange
    final paramsBuilder = PostParamsBuilder();

    //act
    final result = paramsBuilder.build();

    //assert
    expect(result, isA<PostParams>());
  });

  test("should set the given params", () {
    //arrange
    final builder = PostParamsBuilder();

    //act
    builder
      ..setTitle("title")
      ..setSlug("slug")
      ..setStatus(PostStatus.pending)
      ..setContent("content")
      ..setExcerpt("excerpt")
      ..setCategories([1, 2])
      ..setTags([1, 2]);

    final result = builder.build();

    //assert
    expect(result.title, "title");
    expect(result.slug, "slug");
    expect(result.status, PostStatus.pending);
    expect(result.content, "content");
    expect(result.excerpt, "excerpt");
    expect(result.categories, [1, 2]);
    expect(result.tags, [1, 2]);
  });

  test("should set the initial value by given object", () {
    //arrange
    final postEntity = FakePostEntity() as PostEntity;
    final builder = PostParamsBuilder();

    //act
    builder.setInitialValues(postEntity);

    final result = builder.build();

    //assert
    expect(result.id, postEntity.id);
    expect(result.title, postEntity.title);
    expect(result.slug, postEntity.slug);
    expect(result.status, postEntity.status);
    expect(result.content, postEntity.content);
    expect(result.excerpt, postEntity.excerpt);
    expect(result.categories, postEntity.categories);
    expect(result.tags, postEntity.tags);
    expect(result.featuredImage, postEntity.featuredMedia);
  });

  test("should get the status with correct value ", () {
    //arrange
    final builder = PostParamsBuilder();

    //act
    builder.setStatus(PostStatus.draft);

    //assert
    expect(builder.status, PostStatus.draft);
  });
}
