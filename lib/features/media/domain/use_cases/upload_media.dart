import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class UploadMedia implements UseCase<UploadMediaResult, String> {
  final MediaRepository _repository;

  UploadMedia({
    required MediaRepository mediaRepository,
  }) : _repository = mediaRepository;

  @override
  Future<Either<Failure, UploadMediaResult>> call(String pathToFile) {
    return _repository.uploadMediaFile(pathToFile);
  }
}

typedef UploadMediaResult = ({Stream<double> stream, CancelToken cancelToken});
