import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_entity.dart';
import 'package:wordpress_companion/features/site_settings/presentation/utils/image_cache_tracker.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 2;

  @override
  String get sourceUrl => "url";
}

class MockImageCacheTracker extends Mock implements ImageCacheTracker {}

class FakeImageProvider extends Fake implements ImageProvider {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late List<MediaEntity> testMediaEntities;

  late MockImageCacheTracker mockImageCacheTracker;

  setUp(() {
    mockImageCacheTracker = MockImageCacheTracker();
    testMediaEntities = List.generate(20, (index) => FakeMediaEntity());
  });

  setUpAll(() {
    registerFallbackValue(FakeImageProvider());
    registerFallbackValue(FakeBuildContext());
  });
  group('SequentialImageList Widget Tests', () {
    testWidgets("should show Nothing when images is not loaded ",
        (tester) async {
      //arrange
      when(
        () => mockImageCacheTracker.isImageCached(any()),
      ).thenAnswer((_) => false);
      when(
        () => mockImageCacheTracker.precache(any(), any()),
      ).thenAnswer((_) async {});

      await _makeTestWidget(
        tester,
        testMediaEntities,
        imageCacheTracker: mockImageCacheTracker,
      );
      await tester.pump(Durations.short1);

      //assert
      expect(find.byType(Image), findsNothing);
    });

    testWidgets("should show Image when images is loaded ", (tester) async {
      //arrange
      when(
        () => mockImageCacheTracker.isImageCached(any()),
      ).thenAnswer((_) => true);
      when(
        () => mockImageCacheTracker.precache(any(), any()),
      ).thenAnswer((_) async {});

      await _makeTestWidget(
        tester,
        testMediaEntities,
        imageCacheTracker: mockImageCacheTracker,
      );
      await tester.pump(Durations.short1);

      //assert
      expect(find.byType(Image), findsAtLeast(5));
    });

    testWidgets('triggers onScrolledToBottom when scrolled to bottom',
        (tester) async {
      bool scrolledToBottomTriggered = false;

      when(
        () => mockImageCacheTracker.isImageCached(any()),
      ).thenAnswer((_) => true);

      when(
        () => mockImageCacheTracker.precache(any(), any()),
      ).thenAnswer((_) async {});

      await _makeTestWidget(
        tester,
        testMediaEntities,
        imageCacheTracker: mockImageCacheTracker,
        onScrolledToBottom: () => scrolledToBottomTriggered = true,
      );
      await tester.pump(Durations.short1);

      // Programmatically scroll to the end
      await tester.drag(find.byType(Scrollable), const Offset(0, -2000));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verify that onScrolledToBottom was triggered
      expect(scrolledToBottomTriggered, isTrue);
    });

    testWidgets('triggers onSelect callback when an image is tapped',
        (WidgetTester tester) async {
      MediaEntity? selectedMedia;
      when(
        () => mockImageCacheTracker.isImageCached(any()),
      ).thenAnswer((_) => true);

      when(
        () => mockImageCacheTracker.precache(any(), any()),
      ).thenAnswer((_) async {});

      await _makeTestWidget(
        tester,
        testMediaEntities,
        imageCacheTracker: mockImageCacheTracker,
        onSelect: (media) => selectedMedia = media,
      );

      // Simulate image loading by pumping a frame
      await tester.pump();

      // Tap on the first image
      await tester.tap(find.byType(Image).first);
      await tester.pump();

      // Verify that onSelect was called with the correct media entity
      expect(selectedMedia, isNotNull);
      expect(selectedMedia?.id, testMediaEntities[0].id);
    });
  });
}

Future<void> _makeTestWidget(
  WidgetTester tester,
  List<MediaEntity> testMediaEntities, {
  VoidCallback? onScrolledToBottom,
  Function(MediaEntity media)? onSelect,
  ScrollController? testScrollController,
  ImageCacheTracker? imageCacheTracker,
}) async {
  // Calling twice because we need to trigger the didUpdateWidget
  await mockNetworkImagesFor(() async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SizedBox(
            height: 400,
            child: SequentialImageList(
              medias: const [],
              imageCacheTracker: ImageCacheTracker(),
              onScrolledToBottom: () {},
              onSelect: (media) {},
              scrollController: ScrollController(),
            ),
          ),
        ),
      ),
    );
  });

  await mockNetworkImagesFor(() async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SizedBox(
            height: 400,
            child: SequentialImageList(
              medias: testMediaEntities,
              imageCacheTracker: imageCacheTracker ?? ImageCacheTracker(),
              onScrolledToBottom: onScrolledToBottom ?? () {},
              onSelect: onSelect ?? (media) {},
              scrollController: testScrollController,
            ),
          ),
        ),
      ),
    );
  });
}
