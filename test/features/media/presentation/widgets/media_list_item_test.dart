import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
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

  @override
  String get authorName => "test";
}

class MockMediaCubit extends MockCubit<MediaState> implements MediaCubit {}

final _mediaEntity = FakeMediaEntity();
void main() {
  late MediaCubit mediaCubit;

  setUp(() {
    mediaCubit = MockMediaCubit();
    when(() => mediaCubit.state).thenAnswer((_) => const MediaState.initial());
  });

  group("popUpMenu -", () {
    testWidgets(
        "should go to editMediaScreen when MenuItem with edit value tapped",
        (tester) async {
      //arrange
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_testWidgetTree(mediaCubit));
      });

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
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(_testWidgetTree(mediaCubit));
      });

      //verification
      expect(find.byType(PopupMenuButton), findsOneWidget);

      //act
      await tester.tap(find.byType(PopupMenuButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("edit_media")));
      await tester.pumpAndSettle();
      final editScreen = tester.widget<EditMediaScreen>(
        find.byType(EditMediaScreen),
      );

      //assert
      expect(editScreen.mediaEntity, isNotNull);
    });
  });
}

Widget _testWidgetTree(MediaCubit mediaCubit) {
  return ScreenUtilInit(
    child: MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => Material(
              child: MediaListItem(media: _mediaEntity),
            ),
            routes: [
              GoRoute(
                name: editMediaScreenRoute,
                path: editMediaScreenRoute,
                builder: (context, state) {
                  final media = state.extra as MediaEntity;
                  return BlocProvider(
                    create: (context) => mediaCubit,
                    child: EditMediaScreen(mediaEntity: media),
                  );
                },
              )
            ],
          )
        ],
      ),
    ),
  );
}
