import '../../media_exports.dart';

class CurrentPageMediasEntity {
  final bool hasMore;
  final List<MediaEntity> medias;

  CurrentPageMediasEntity({
    required this.hasMore,
    required this.medias,
  });
}
