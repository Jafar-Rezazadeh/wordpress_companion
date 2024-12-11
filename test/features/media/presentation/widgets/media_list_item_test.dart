import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

import '../../../../dummy_stuff.dart';

class MockMediaCubit extends MockCubit<MediaState> implements MediaCubit {}

final _mediaEntity = DummyObjects.mediaEntity;
void main() {
  late MediaCubit mediaCubit;

  setUp(() {
    mediaCubit = MockMediaCubit();
    when(() => mediaCubit.state).thenAnswer((_) => const MediaState.initial());
  });

  group("popUpMenu -", () {
    group("Edit", () {
      testWidgets("should go to editMediaScreen when edit_media tapped",
          (tester) async {
        //arrange
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            GetMaterialApp(
              getPages: [
                GetPage(
                  name: editMediaScreenRoute,
                  page: () {
                    final media = Get.arguments as MediaEntity;
                    return BlocProvider(
                      create: (context) => mediaCubit,
                      child: EditMediaScreen(mediaEntity: media),
                    );
                  },
                )
              ],
              home: _testWidgetTree(mediaCubit),
            ),
          );
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
          "should send the mediaEntity to editMediaScreen when edit_media tapped ",
          (tester) async {
        //arrange
        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            GetMaterialApp(
              getPages: [
                GetPage(
                  name: editMediaScreenRoute,
                  page: () {
                    final media = Get.arguments as MediaEntity;
                    return BlocProvider(
                      create: (context) => mediaCubit,
                      child: EditMediaScreen(mediaEntity: media),
                    );
                  },
                )
              ],
              home: _testWidgetTree(mediaCubit),
            ),
          );
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

    group("delete", () {
      testWidgets("should open are_you_sure_dialog when delete_media tapped",
          (tester) async {
        //arrange
        await tester.pumpWidget(MaterialApp(home: _testWidgetTree(mediaCubit)));

        //verification
        expect(find.byType(PopupMenuButton), findsOneWidget);

        //act
        await tester.tap(find.byType(PopupMenuButton));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("delete_media")));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("are_you_sure_dialog")), findsOneWidget);
      });

      testWidgets(
          "should invoke mediaCubit.delete when delete_media is confirmed ",
          (tester) async {
        //arrange
        await tester.pumpWidget(
          BlocProvider(
            create: (context) => mediaCubit,
            child: MaterialApp(home: _testWidgetTree(mediaCubit)),
          ),
        );

        //verification
        expect(find.byType(PopupMenuButton), findsOneWidget);

        //act
        await tester.tap(find.byType(PopupMenuButton));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("delete_media")));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("confirm_button")));
        await tester.pumpAndSettle();

        //assert
        verify(() => mediaCubit.deleteMedia(any())).called(1);
      });
    });
  });
}

Widget _testWidgetTree(MediaCubit mediaCubit) {
  // return ScreenUtilInit(
  //   child: MaterialApp.router(
  //     routerConfig: GoRouter(
  //       initialLocation: "/",
  //       routes: [
  //         ShellRoute(
  //           builder: (context, state, child) => BlocProvider(
  //             create: (context) => mediaCubit,
  //             child: child,
  //           ),
  //           routes: [
  //             GoRoute(
  //               path: "/",
  //               builder: (context, state) => Material(
  //                 child: MediaListItem(media: _mediaEntity),
  //               ),
  //               routes: [
  //                 GoRoute(
  //                   name: editMediaScreenRoute,
  //                   path: editMediaScreenRoute,
  //                   builder: (context, state) {
  //                     final media = state.extra as MediaEntity;
  //                     return EditMediaScreen(mediaEntity: media);
  //                   },
  //                 )
  //               ],
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   ),
  // );
  return ScreenUtilInit(
    child: Material(child: MediaListItem(media: _mediaEntity)),
  );
}
