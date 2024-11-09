import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class CreatePost implements UseCase<PostEntity, CreatePostParams> {
  final PostsRepository _postsRepository;

  CreatePost({
    required PostsRepository postsRepository,
  }) : _postsRepository = postsRepository;

  @override
  Future<Either<Failure, PostEntity>> call(CreatePostParams params) {
    return _postsRepository.createPost(params);
  }
}

class CreatePostParams {
  final String title;
  final String slug;
  final String content;
  final String excerpt;
  final List<int> categories;
  final List<int> tags;
  final int featuredImage;

  CreatePostParams({
    required this.title,
    required this.slug,
    required this.content,
    required this.excerpt,
    required this.categories,
    required this.tags,
    required this.featuredImage,
  });
}
