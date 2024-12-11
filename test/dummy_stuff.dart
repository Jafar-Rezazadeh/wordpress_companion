import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_details_entity.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_entity.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';
import 'package:wordpress_companion/features/site_settings/domain/use_cases/update_site_settings.dart';

class DummyObjects {
  static ProfileEntity profileEntity({String? name}) => ProfileEntity(
        id: 0,
        userName: "userName",
        name: name ?? " name",
        firstName: "firstName",
        lastName: "lastName",
        email: "email@gmail.com",
        url: "url",
        description: "description",
        link: "link",
        locale: "locale",
        nickName: "nickName",
        slug: "slug",
        registeredDate: DateTime.now(),
        avatarUrls: const ProfileAvatarUrlsEntity(
            size24px: "size24px", size48px: "size48px", size96px: "size96px"),
        roles: const [],
      );
  static MediaEntity mediaEntity = MediaEntity(
    id: 1,
    date: DateTime.now(),
    guid: "guid",
    modified: DateTime.now(),
    slug: "slug",
    status: "status",
    type: "type",
    link: "link",
    title: "title",
    author: 1,
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
    mediaDetails: const MediaDetailsEntity(fileSize: 0),
    post: 0,
    sourceUrl: "sourceUrl",
    authorName: "authorName",
  );
}

class DummyParams {
  static UpdateMyProfileParams updateMyProfileParams =
      const UpdateMyProfileParams(
    name: "displayName",
    firstName: "firstName",
    lastName: "lastName",
    email: "email",
    url: "url",
    description: "description",
    nickName: "nickName",
    slug: "slug",
  );

  static UpdateSiteSettingsParams updateSiteSettingsParams =
      const UpdateSiteSettingsParams(
    title: "title",
    description: "description",
    siteIcon: 0,
    url: "url",
    email: "email",
    timeZone: "timeZone",
    dateFormat: "dateFormat",
    timeFormat: "timeFormat",
    startOfWeek: 1,
  );

  static PostParams postParams = PostParams(
    id: 2,
    title: "title",
    slug: "slug",
    status: PostStatusEnum.publish,
    content: "content",
    excerpt: "excerpt",
    categories: [],
    tags: [],
    featuredImage: 2,
  );
}
