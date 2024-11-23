import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../core/core_export.dart';

abstract class MediaBoxBuilder {
  final MediaBoxBuilder? nextBuilder;

  MediaBoxBuilder({required this.nextBuilder});

  Widget render(String sourceUrl, String label);

  bool canRender(MimeTypeEnum mimeType);

  Widget build({
    required MimeTypeEnum mimetype,
    required String sourceUrl,
    required String label,
  }) {
    if (canRender(mimetype)) {
      return render(sourceUrl, label);
    } else {
      return nextBuilder?.build(
              mimetype: mimetype, sourceUrl: sourceUrl, label: label) ??
          Container();
    }
  }
}

class ImageBoxBuilder extends MediaBoxBuilder {
  ImageBoxBuilder({required super.nextBuilder});

  @override
  bool canRender(MimeTypeEnum mimeType) => mimeType == MimeTypeEnum.image;

  @override
  Widget render(String sourceUrl, String label) {
    return Image.network(
      key: const Key("image_show_box"),
      sourceUrl,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error_outline),
    );
  }
}

class VideoBoxBuilder extends MediaBoxBuilder {
  VideoBoxBuilder({required super.nextBuilder});

  @override
  bool canRender(MimeTypeEnum mimeType) => mimeType == MimeTypeEnum.video;

  @override
  Widget render(String sourceUrl, String label) {
    return VideoPlayerWidget(sourceUrl: sourceUrl);
  }
}

class FileBoxBuilder extends MediaBoxBuilder {
  FileBoxBuilder({required super.nextBuilder});

  @override
  bool canRender(MimeTypeEnum mimeType) =>
      mimeType != MimeTypeEnum.image && mimeType != MimeTypeEnum.video;

  @override
  Widget render(String sourceUrl, String label) {
    return Container(
      key: const Key("file_show_box"),
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 50,
            spreadRadius: -30,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 80,
            FontAwesomeIcons.file,
            color: ColorPallet.text,
          ),
          const Gap(10),
          Text(label, style: TextStyle(fontSize: 16, color: ColorPallet.text)),
        ],
      ),
    );
  }
}
