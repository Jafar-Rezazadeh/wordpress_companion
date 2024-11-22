import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

import '../core_export.dart';

abstract class TagsService {
  Future<Either<Failure, List<TagEntity>>> getTagsByIds(List<int> ids);
  Future<Either<Failure, List<TagEntity>>> searchTag(String name);
  Future<Either<Failure, TagEntity>> createTag(String name);
}
