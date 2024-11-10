import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

abstract class PostsRepository {
  Future<Either<Failure, PostsPageResult>> getPostsPerPage(
    GetPostsPerPageParams params,
  );
  Future<Either<Failure, PostEntity>> createPost(PostParams params);
  Future<Either<Failure, PostEntity>> updatePost(PostParams params);
  Future<Either<Failure, PostEntity>> deletePost(int id);
}
