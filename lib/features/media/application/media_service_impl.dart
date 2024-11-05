import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/media_service.dart';
import 'package:wordpress_companion/features/media/domain/entities/current_page_medias_entity.dart';
import 'package:wordpress_companion/features/media/domain/use_cases/get_media_per_page.dart';

class MediaServiceImpl implements MediaService {
  final GetMediaPerPage _getMediaPerPage;

  MediaServiceImpl({required GetMediaPerPage getMediaPerPage})
      : _getMediaPerPage = getMediaPerPage;
  @override
  Future<Either<Failure, CurrentPageMediasEntity>> getMediaPerPage(
      GetMediaPerPageParams params) {
    return _getMediaPerPage.call(params);
  }
}
