import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/media/application/image_selector/utils/image_cache_tracker.dart';

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  testWidgets(
      "should add the imageProvider to cached images when it is not cached",
      (tester) async {
    //arrange
    final imageCacheTracker = ImageCacheTracker(
      precacheImageTest: (provider) async {},
    );
    const imageProvider = NetworkImage("url");

    //act
    await imageCacheTracker.precache(FakeBuildContext(), imageProvider);

    //assert
    expect(imageCacheTracker.isImageCached(imageProvider), true);
  });

  test(
      "should NOT add the imageProvider to cached images when it is already cached",
      () async {
    //arrange
    final imageCacheTracker = ImageCacheTracker(
      precacheImageTest: (provider) async {},
    );
    const imageProvider = NetworkImage("url");

    //verification
    await imageCacheTracker.precache(FakeBuildContext(), imageProvider);
    expect(ImageCacheTracker().isImageCached(imageProvider), true);

    //act
    bool isInvokedAgain = false;
    await ImageCacheTracker(
      precacheImageTest: (provider) async {
        isInvokedAgain = true;
      },
    ).precache(FakeBuildContext(), imageProvider);

    //assert
    expect(isInvokedAgain, false);
  });
}
