import '../../media_exports.dart';

class CurrentPageMedias {
  final bool hasNextPage;
  final List<MediaEntity> medias;

  CurrentPageMedias({
    required this.hasNextPage,
    required this.medias,
  });
}
