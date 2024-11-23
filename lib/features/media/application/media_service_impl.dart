import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/media_service.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MediaServiceImpl implements MediaService {
  final GetMediaPerPage _getMediaPerPage;
  final GetSingleMedia _getSingleMedia;

  MediaServiceImpl({
    required GetMediaPerPage getMediaPerPage,
    required GetSingleMedia getSingleMedia,
  })  : _getMediaPerPage = getMediaPerPage,
        _getSingleMedia = getSingleMedia;

  @override
  Future<Either<Failure, CurrentPageMedias>> getMediaPerPage(
      GetMediaPerPageParams params) {
    return _getMediaPerPage.call(params);
  }

  @override
  Future<Either<Failure, MediaEntity>> getSingleMedia(int id) {
    return _getSingleMedia.call(id);
  }
}
