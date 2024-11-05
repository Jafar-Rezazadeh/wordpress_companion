import 'package:flutter/material.dart';

import '../../../../../core/core_export.dart';

class MediaListItemLeading extends StatelessWidget {
  final String mimeType;
  final String sourceUrl;

  const MediaListItemLeading({
    super.key,
    required this.mimeType,
    required this.sourceUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(smallCornerRadius),
      child: _content(),
    );
  }

  Widget _content() {
    final mimeTypeEnum = MimeTypeRecognizer.fromString(mimeType);
    if (mimeTypeEnum == MimeType.video) {
      return _iconBox(
        key: const Key("video_box"),
        icon: Icons.video_file,
      );
    }
    if (mimeTypeEnum == MimeType.image) {
      return _imageBox();
    }
    return _iconBox(
      key: const Key("file_box"),
      icon: Icons.file_present_rounded,
    );
  }

  Widget _imageBox() {
    return Image.network(
      key: const Key("image_box"),
      // HACK: remove replace on production it is just for local host
      sourceUrl.replaceAll("https://localhost", "http://192.168.1.2"),
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    );
  }

  Widget _iconBox({Key? key, required IconData icon}) {
    return Container(
      key: key,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
          ),
          BoxShadow(
            blurStyle: BlurStyle.normal,
            blurRadius: 10,
            color: Colors.white,
            spreadRadius: -4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Icon(icon),
    );
  }
}
