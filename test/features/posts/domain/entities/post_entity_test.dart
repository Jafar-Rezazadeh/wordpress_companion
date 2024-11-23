import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/features/posts/domain/entities/post_entity.dart';

void main() {
  test("should include id in props ", () {
    //arrange
    final post = _createPostEntity(1);

    //act
    final props = post.props;

    //assert
    expect(props, [1]);
  });

  test("should be same if a id is same", () {
    //arrange
    final post1 = _createPostEntity(1);
    final post2 = _createPostEntity(1);

    //act

    //assert
    expect(post1 == post2, isTrue);
  });
  test("should NOT be same if a id is different", () {
    //arrange
    final post1 = _createPostEntity(1);
    final post2 = _createPostEntity(2);

    //act

    //assert
    expect(post1 == post2, isFalse);
  });
}

PostEntity _createPostEntity(int id) {
  return PostEntity(
      id: id,
      date: DateTime(1),
      guid: "guid",
      modified: DateTime(1),
      slug: "slug",
      status: PostStatusEnum.publish,
      type: "type",
      link: "link",
      title: "title",
      content: "content",
      excerpt: "excerpt",
      author: 1,
      authorName: "authorName",
      featuredMedia: 1,
      featureMediaLink: "featureMediaLink",
      commentStatus: "commentStatus",
      categories: const [],
      tags: const []);
}
