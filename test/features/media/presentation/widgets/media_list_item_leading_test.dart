import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_list_item_leading.dart';

void main() {
  testWidgets("should show the image when mimetype is image", (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: MediaListItemLeading(
            mimeType: "image/jpeg",
            sourceUrl: "sourceUrl",
          ),
        ),
      ),
    );
    //assert
    expect(find.byKey(const Key("image_box")), findsOneWidget);
  });

  testWidgets("should show a video box icon when mimetype is video",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: MediaListItemLeading(
            mimeType: "video/mp4",
            sourceUrl: "sourceUrl",
          ),
        ),
      ),
    );
    //assert
    expect(find.byKey(const Key("video_box")), findsOneWidget);
  });

  testWidgets("should show file_box when mimeType is other things",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: MediaListItemLeading(
            mimeType: "application/pdf",
            sourceUrl: "sourceUrl",
          ),
        ),
      ),
    );
    //assert
    expect(find.byKey(const Key("file_box")), findsOneWidget);
  });
}
