import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaRemoteDataSource _mediaRemoteDataSource;

  MediaRepositoryImpl({
    required MediaRemoteDataSource mediaRemoteDataSource,
  }) : _mediaRemoteDataSource = mediaRemoteDataSource;

  @override
  Future<Either<Failure, bool>> deleteMedia(int id) async {
    try {
      final result = await _mediaRemoteDataSource.deleteMedia(id);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, CurrentPageMediasEntity>> getMediaPerPage(
      GetMediaPerPageParams params) async {
    try {
      final result = await _mediaRemoteDataSource.getMediasPerPage(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, MediaEntity>> updateMedia(
      UpdateMediaParams params) async {
    try {
      final result = await _mediaRemoteDataSource.updateMedia(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, UploadMediaResult>> uploadMediaFile(
    String pathToFile,
  ) async {
    try {
      final result = _mediaRemoteDataSource.uploadMediaFile(pathToFile);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> cancelMediaUpload(
      CancelToken cancelToken) async {
    try {
      final result =
          await _mediaRemoteDataSource.cancelMediaUpload(cancelToken);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }
}
