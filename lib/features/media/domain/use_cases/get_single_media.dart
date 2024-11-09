import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

import '../../media_exports.dart';

class GetSingleMedia implements UseCase<MediaEntity, int> {
  final MediaRepository _mediaRepository;

  GetSingleMedia({required MediaRepository mediaRepository})
      : _mediaRepository = mediaRepository;

  @override
  Future<Either<Failure, MediaEntity>> call(int id) {
    return _mediaRepository.getSingleMedia(id);
  }
}
