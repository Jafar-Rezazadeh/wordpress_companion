import 'package:dartz/dartz.dart';

import 'package:wordpress_companion/core/errors/failures.dart';

import '../../posts_exports.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource _postsRemoteDataSource;

  PostsRepositoryImpl({
    required PostsRemoteDataSource postsRemoteDataSource,
  }) : _postsRemoteDataSource = postsRemoteDataSource;

  @override
  Future<Either<Failure, PostEntity>> createPost(PostParams params) async {
    try {
      final result = await _postsRemoteDataSource.createPost(params);
      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePost(int id) async {
    try {
      final result = await _postsRemoteDataSource.deletePost(id);
      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, PostsPageResult>> getPostsPerPage(
    GetPostsPerPageParams params,
  ) async {
    try {
      final result = await _postsRemoteDataSource.getPostsPerPage(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> updatePost(PostParams params) async {
    try {
      final result = await _postsRemoteDataSource.updatePost(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }
}
