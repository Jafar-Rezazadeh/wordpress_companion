import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/widgets/video_player.dart';

void main() {
  testWidgets('should return CustomVideoPlayer when sourceUrl is correct',
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: VideoPlayerWidget(
            sourceUrl:
                "https://videos.pexels.com/video-files/2795171/2795171-uhd_3840_2160_25fps.mp4",
          ),
        ),
      ),
    );
    //assert
    expect(find.byType(CustomVideoPlayer), findsOneWidget);
  });
  testWidgets("should return error_video_box when error occurs",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: VideoPlayerWidget(
            sourceUrl: "sourceUrl",
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    //assert
    expect(find.byKey(const Key("error_video_box")), findsOneWidget);
  });
}
