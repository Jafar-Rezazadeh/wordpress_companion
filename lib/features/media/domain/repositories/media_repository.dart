import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

import '../../media_exports.dart';
import '../use_cases/update_media.dart';

abstract class MediaRepository {
  Future<Either<Failure, List<MediaEntity>>> getAllMedia();
  Future<Either<Failure, MediaEntity>> uploadMedia(String pathToFile);
  Future<Either<Failure, MediaEntity>> updateMedia(UpdateMediaParams params);
  Future<Either<Failure, bool>> deleteMedia(int id);
}
