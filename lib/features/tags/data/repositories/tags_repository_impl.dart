import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class TagsRepositoryImpl implements TagsRepository {
  final TagsRemoteDataSource _tagsRemoteDataSource;

  TagsRepositoryImpl({
    required TagsRemoteDataSource tagsRemoteDataSource,
  }) : _tagsRemoteDataSource = tagsRemoteDataSource;

  @override
  Future<Either<Failure, TagEntity>> createTag(String name) async {
    try {
      final result = await _tagsRemoteDataSource.createTag(name);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, List<TagEntity>>> getTagsByIds(List<int> ids) async {
    try {
      final result = await _tagsRemoteDataSource.getTagsByIds(ids);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, List<TagEntity>>> searchTag(String name) async {
    try {
      final result = await _tagsRemoteDataSource.searchTag(name);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }
}
