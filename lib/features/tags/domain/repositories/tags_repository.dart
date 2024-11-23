import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/features/tags/domain/entities/tag_entity.dart';

import '../../../../core/core_export.dart';

abstract class TagsRepository {
  Future<Either<Failure, TagEntity>> createTag(String name);
  Future<Either<Failure, List<TagEntity>>> searchTag(String name);
  Future<Either<Failure, List<TagEntity>>> getTagsByIds(List<int> ids);
}
