import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

import '../../media_exports.dart';

abstract class MediaRepository {
  Future<Either<Failure, CurrentPageMedias>> getMediaPerPage(
      GetMediaPerPageParams params);
  Future<Either<Failure, UploadMediaResult>> uploadMediaFile(String pathToFile);
  Future<Either<Failure, MediaEntity>> updateMedia(UpdateMediaParams params);
  Future<Either<Failure, bool>> deleteMedia(int id);
  Future<Either<Failure, void>> cancelMediaUpload(CancelToken cancelToken);
  Future<Either<Failure, MediaEntity>> getSingleMedia(int id);
}
