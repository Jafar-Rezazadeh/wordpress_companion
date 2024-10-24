import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

void main() {
  final dummyMediaEntity = MediaEntity(
      id: 1,
      date: DateTime(1),
      guid: "guid",
      modified: DateTime(4),
      slug: "slug",
      status: "status",
      type: "type",
      link: "link",
      title: "title",
      author: 2,
      featuredMedia: 1,
      commentStatus: "commentStatus",
      pingStatus: "pingStatus",
      template: "template",
      permalinkTemplate: "permalinkTemplate",
      generatedSlug: "generatedSlug",
      classList: const [],
      description: "description",
      caption: "caption",
      altText: "altText",
      mediaType: "mediaType",
      mimeType: "mimeType",
      mediaDetails: const MediaDetailsEntity(fileSize: 120),
      post: 1,
      sourceUrl: "sourceUrl");

  test("should include the id in props ", () {
    //arrange
    final media = dummyMediaEntity;

    //act
    final props = media.props;

    //assert
    expect(props, [media.id]);
  });
}
