import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/core/router/go_router_config.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/screens/edit_media_screen.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_list_item.dart';

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 2;
  @override
  String get title => "title";
  @override
  DateTime get date => DateTime.now();
  @override
  String get sourceUrl => "sourceUrl";
  @override
  String get mimeType => "image/jpeg";

  @override
  int get author => 3;

  @override
  MediaDetailsEntity get mediaDetails =>
      const MediaDetailsEntity(fileSize: 500);

  @override
  String get altText => "altText";
  @override
  String get caption => "";

  @override
  String get description => "description";
}

void main() {
  group("popUpMenu -", () {
    testWidgets(
        "should go to editMediaScreen when MenuItem with edit value tapped",
        (tester) async {
      //arrange
      await _pumpTestWidgetTree(tester);

      //verification
      expect(find.byType(PopupMenuButton), findsOneWidget);

      //act
      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("edit_media")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(EditMediaScreen), findsOneWidget);
    });

    testWidgets(
        "should send the mediaEntity to editMediaScreen when MenuItem with edit value tapped ",
        (tester) async {
      //arrange
      await _pumpTestWidgetTree(tester);

      //verification
      expect(find.byType(PopupMenuButton), findsOneWidget);

      //act
      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("edit_media")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(MediaListItem), findsNothing);
      expect(find.byType(EditMediaScreen), findsOneWidget);
      expect(find.text(FakeMediaEntity().title), findsOneWidget);
    });
  });
}

Future<Null> _pumpTestWidgetTree(WidgetTester tester) {
  return mockNetworkImagesFor(() async {
    await tester.pumpWidget(
      ScreenUtilInit(
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: "/",
            routes: [
              GoRoute(
                path: "/",
                builder: (context, state) => Material(
                  child: MediaListItem(media: FakeMediaEntity()),
                ),
                routes: [
                  GoRoute(
                    name: editMediaScreenRoute,
                    path: editMediaScreenRoute,
                    builder: (context, state) {
                      final media = state.extra as MediaEntity;
                      return EditMediaScreen(mediaEntity: media);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}
