import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class CancelMediaUpload implements UseCase<void, CancelToken> {
  final MediaRepository _mediaRepository;

  CancelMediaUpload({required MediaRepository mediaRepository})
      : _mediaRepository = mediaRepository;
  @override
  Future<Either<Failure, void>> call(CancelToken cancelToken) {
    return _mediaRepository.cancelMediaUpload(cancelToken);
  }
}
