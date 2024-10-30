import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_show_box.dart';

void main() {
  final imageBoxFinder = find.byKey(const Key("image_show_box"));
  final videoBoxFinder = find.byKey(const Key("video_show_box"));
  final fileBoxFinder = find.byKey(const Key("file_show_box"));
  testWidgets("should return image_box when MimeType is image", (tester) async {
    //arrange
    await _buildTestWidget(tester, MimeType.image, "sourceUrl");

    //assert
    expect(imageBoxFinder, findsOneWidget);
  });

  testWidgets("should build videoBox when MimeType is video", (tester) async {
    //arrange
    await _buildTestWidget(tester, MimeType.video, "sourceUrl");

    //assert
    expect(videoBoxFinder, findsOneWidget);
  });

  testWidgets("should build fileBox when MimeType is file", (tester) async {
    //arrange
    await _buildTestWidget(tester, MimeType.file, "sourceUrl");

    //act

    //assert
    expect(fileBoxFinder, findsOneWidget);
  });
}

Future<void> _buildTestWidget(
    WidgetTester tester, MimeType mimeType, String sourceUrl) async {
  final mediaBoxBuilder = FileBoxBuilder(
    nextBuilder: VideoBoxBuilder(
      nextBuilder: ImageBoxBuilder(nextBuilder: null),
    ),
  );

  await mockNetworkImagesFor(
    () async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: mediaBoxBuilder.build(
                mimetype: mimeType, sourceUrl: sourceUrl, label: "test"),
          ),
        ),
      );
    },
  );
}
