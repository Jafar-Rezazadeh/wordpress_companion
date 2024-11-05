import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

import '../../media_exports.dart';

class DeleteMedia implements UseCase<bool, int> {
  final MediaRepository _repository;

  DeleteMedia({
    required MediaRepository mediaRepository,
  }) : _repository = mediaRepository;

  @override
  Future<Either<Failure, bool>> call(int id) {
    return _repository.deleteMedia(id);
  }
}
