import '../../posts_exports.dart';

class PostsPageResult {
  final bool hasNextPage;
  final List<PostEntity> posts;

  PostsPageResult({
    required this.hasNextPage,
    required this.posts,
  });
}
