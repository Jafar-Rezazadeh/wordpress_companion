import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/domain/use_cases/update_media.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MediaRepositoryImpl implements MediaRepository {
  @override
  Future<Either<Failure, bool>> deleteMedia(int id) {
    // TODO: implement deleteMedia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MediaEntity>>> getAllMedia() {
    // TODO: implement getAllMedia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MediaEntity>> updateMedia(UpdateMediaParams params) {
    // TODO: implement updateMedia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MediaEntity>> uploadMedia(String pathToFile) {
    // TODO: implement uploadMedia
    throw UnimplementedError();
  }
}
