import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class UpdatePost implements UseCase<PostEntity, UpdatePostParams> {
  final PostsRepository _postsRepository;

  UpdatePost({
    required PostsRepository postsRepository,
  }) : _postsRepository = postsRepository;
  @override
  Future<Either<Failure, PostEntity>> call(UpdatePostParams params) {
    return _postsRepository.updatePost(params);
  }
}

class UpdatePostParams {
  final int id;
  final String title;
  final String slug;
  final String content;
  final String excerpt;
  final List<int> categories;
  final List<int> tags;
  final int featuredImage;

  UpdatePostParams({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.excerpt,
    required this.categories,
    required this.tags,
    required this.featuredImage,
  });
}
