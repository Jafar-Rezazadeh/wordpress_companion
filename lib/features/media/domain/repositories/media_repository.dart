import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

import '../../media_exports.dart';

abstract class MediaRepository {
  Future<Either<Failure, CurrentPageMediasEntity>> getMediaPerPage(
      GetMediaPerPageParams params);
  Future<Either<Failure, Stream<double>>> uploadMediaFile(String pathToFile);
  Future<Either<Failure, MediaEntity>> updateMedia(UpdateMediaParams params);
  Future<Either<Failure, bool>> deleteMedia(int id);
}
