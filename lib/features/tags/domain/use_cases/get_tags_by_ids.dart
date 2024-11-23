import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class GetTagsByIds implements UseCase<List<TagEntity>, List<int>> {
  final TagsRepository _tagsRepository;

  GetTagsByIds({
    required TagsRepository tagsRepository,
  }) : _tagsRepository = tagsRepository;

  @override
  Future<Either<Failure, List<TagEntity>>> call(List<int> params) {
    return _tagsRepository.getTagsByIds(params);
  }
}
