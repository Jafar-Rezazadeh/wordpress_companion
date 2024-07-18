import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/home/home_exports.dart';

import '../entities/post_entity.dart';

abstract class PostService {
  Future<Either<Failure, List<PostEntity>>> getLatestPosts(GetLatestPostsParams params);
}
