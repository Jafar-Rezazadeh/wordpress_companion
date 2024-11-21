import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/tags_service.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class TagsServiceImpl implements TagsService {
  final CreateTag _createTag;
  final GetTagsByIds _getTagsByIds;
  final SearchTag _searchTag;

  TagsServiceImpl({
    required CreateTag createTag,
    required GetTagsByIds getTagsByIds,
    required SearchTag searchTag,
  })  : _createTag = createTag,
        _getTagsByIds = getTagsByIds,
        _searchTag = searchTag;

  @override
  Future<Either<Failure, TagEntity>> createTag(String name) {
    return _createTag(name);
  }

  @override
  Future<Either<Failure, List<TagEntity>>> getTagsByIds(List<int> ids) {
    return _getTagsByIds(ids);
  }

  @override
  Future<Either<Failure, List<TagEntity>>> searchTag(String name) {
    return _searchTag(name);
  }
}
