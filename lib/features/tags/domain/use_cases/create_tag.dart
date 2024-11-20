import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

import '../../tags_exports.dart';

class CreateTag implements UseCase<TagEntity, String> {
  final TagsRepository _tagsRepository;

  CreateTag({
    required TagsRepository tagsRepository,
  }) : _tagsRepository = tagsRepository;

  @override
  Future<Either<Failure, TagEntity>> call(String params) {
    return _tagsRepository.createTag(params);
  }
}
