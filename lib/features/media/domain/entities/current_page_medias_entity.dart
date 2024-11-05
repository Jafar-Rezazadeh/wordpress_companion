import '../../media_exports.dart';

class CurrentPageMediasEntity {
  final bool hasNextPage;
  final List<MediaEntity> medias;

  CurrentPageMediasEntity({
    required this.hasNextPage,
    required this.medias,
  });
}
