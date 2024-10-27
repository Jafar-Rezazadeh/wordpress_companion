import 'package:flutter/material.dart';

import '../../../../core/core_export.dart';

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
    // TODO: show specific leading based on mimeType
    return ClipRRect(
      borderRadius: BorderRadius.circular(smallCornerRadius),
      child: Image.network(
        // FIXME: remove replay on production it is just for local host
        sourceUrl.replaceAll("https://localhost", "http://192.168.1.2"),
        fit: BoxFit.fill,
        loadingBuilder: _imageLoadingProgress,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      ),
    );
  }

  Widget _imageLoadingProgress(context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }
}
