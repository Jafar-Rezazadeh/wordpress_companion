import 'package:dio/dio.dart';

import '../../../media_exports.dart';

abstract class MediaRemoteDataSource {
  Future<bool> deleteMedia(int id);
  Future<CurrentPageMedias> getMediasPerPage(GetMediaPerPageParams params);
  Future<MediaModel> updateMedia(UpdateMediaParams params);
  UploadMediaResult uploadMediaFile(String pathToFile);
  Future<void> cancelMediaUpload(CancelToken cancelToken);
  Future<MediaModel> getSingleMedia(int id);
}
