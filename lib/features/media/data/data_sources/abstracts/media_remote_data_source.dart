import '../../../media_exports.dart';

abstract class MediaRemoteDataSource {
  Future<bool> deleteMedia(int id);
  Future<CurrentPageMediasEntity> getMediasPerPage(
      GetMediaPerPageParams params);
  Future<MediaModel> updateMedia(UpdateMediaParams params);
  Stream<double> uploadMediaFile(String pathToFile);
}
