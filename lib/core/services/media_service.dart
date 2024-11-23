import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

import '../core_export.dart';

abstract class MediaService {
  Future<Either<Failure, CurrentPageMedias>> getMediaPerPage(
    GetMediaPerPageParams params,
  );
  Future<Either<Failure, MediaEntity>> getSingleMedia(int id);
}
