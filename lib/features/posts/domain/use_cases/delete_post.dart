import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class DeletePost implements UseCase<PostEntity, int> {
  final PostsRepository _postsRepository;

  DeletePost({
    required PostsRepository postsRepository,
  }) : _postsRepository = postsRepository;

  @override
  Future<Either<Failure, PostEntity>> call(int params) {
    return _postsRepository.deletePost(params);
  }
}
