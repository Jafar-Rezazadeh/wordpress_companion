import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class SearchTag implements UseCase<List<TagEntity>, String> {
  final TagsRepository _tagsRepository;

  SearchTag({
    required TagsRepository tagsRepository,
  }) : _tagsRepository = tagsRepository;

  @override
  Future<Either<Failure, List<TagEntity>>> call(String params) {
    return _tagsRepository.searchTag(params);
  }
}
