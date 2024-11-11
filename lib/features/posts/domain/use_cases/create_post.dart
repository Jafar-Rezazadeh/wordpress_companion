import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class CreatePost implements UseCase<PostEntity, PostParams> {
  final PostsRepository _postsRepository;

  CreatePost({
    required PostsRepository postsRepository,
  }) : _postsRepository = postsRepository;

  @override
  Future<Either<Failure, PostEntity>> call(PostParams params) {
    return _postsRepository.createPost(params);
  }
}
