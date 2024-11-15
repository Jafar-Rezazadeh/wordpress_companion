import 'package:wordpress_companion/features/posts/posts_exports.dart';

abstract class PostsRemoteDataSource {
  Future<PostModel> createPost(PostParams params);
  Future<bool> deletePost(int id);
  Future<PostsPageResult> getPostsPerPage(GetPostsPerPageParams params);
  Future<PostModel> updatePost(PostParams params);
}
