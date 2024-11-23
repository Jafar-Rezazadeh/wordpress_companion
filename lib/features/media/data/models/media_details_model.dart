import 'package:wordpress_companion/features/media/media_exports.dart';

class MediaDetailsModel extends MediaDetailsEntity {
  const MediaDetailsModel({
    required super.fileSize,
    super.height,
    super.width,
  });

  factory MediaDetailsModel.fromJson(dynamic json) {
    return MediaDetailsModel(
      fileSize: json['filesize'] as int,
      height: json['height'] as int?,
      width: json['width'] as int?,
    );
  }
}
