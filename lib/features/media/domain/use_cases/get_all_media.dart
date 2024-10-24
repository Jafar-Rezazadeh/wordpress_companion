import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_entity.dart';

import '../repositories/media_repository.dart';

class GetAllMedia implements UseCase<List<MediaEntity>, NoParams> {
  final MediaRepository _repository;

  GetAllMedia({required MediaRepository mediaRepository})
      : _repository = mediaRepository;

  @override
  Future<Either<Failure, List<MediaEntity>>> call(NoParams params) {
    return _repository.getAllMedia();
  }
}
