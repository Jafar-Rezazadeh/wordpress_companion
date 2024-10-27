import '../../media_exports.dart';

class CurrentPageMediasEntity {
  final bool hasMoreMedias;
  final List<MediaEntity> medias;

  CurrentPageMediasEntity({
    required this.hasMoreMedias,
    required this.medias,
  });
}
