import 'package:flutter/material.dart';

class ImageCacheTracker {
  final Future<void> Function(
    ImageProvider<Object> provider,
  )? precacheImageTest;

  ImageCacheTracker({this.precacheImageTest});

  static final Set<ImageProvider> _cachedImages = {};

  Future<void> precache(
      BuildContext context, ImageProvider imageProvider) async {
    if (!_cachedImages.contains(imageProvider)) {
      precacheImageTest != null
          ? await precacheImageTest!(imageProvider)
          : await precacheImage(imageProvider, context);
      _cachedImages.add(imageProvider);
    }
  }

  bool isImageCached(ImageProvider imageProvider) {
    return _cachedImages.contains(imageProvider);
  }
}
