import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/home/domain/entities/post_entity.dart';
import 'package:wordpress_companion/features/home/home_exports.dart';

class GetLatestPosts implements UseCase<List<PostEntity>, GetLatestPostsParams> {
  final PostService _postService;

  GetLatestPosts({required PostService postService}) : _postService = postService;
  @override
  Future<Either<Failure, List<PostEntity>>> call(GetLatestPostsParams params) async {
    return await _postService.getLatestPosts(params);
  }
}

class GetLatestPostsParams extends Equatable {
  final int postsPerPage;
  final int pageNumber;

  const GetLatestPostsParams({this.postsPerPage = 10, this.pageNumber = 1});

  @override
  List<Object?> get props => [postsPerPage, pageNumber];
}
