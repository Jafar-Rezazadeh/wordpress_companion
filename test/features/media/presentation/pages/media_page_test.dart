import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/pages/media_page.dart';

class MockMediaCubit extends MockCubit<MediaState> implements MediaCubit {}

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 3;
  @override
  String get title => "title";
  @override
  DateTime get date => DateTime(1);
  @override
  String get mimeType => "image/jpeg";
  @override
  String get sourceUrl => "url";
}

void main() {
  late MediaCubit mediaCubit;

  setUpAll(() {
    registerFallbackValue(GetMediaPerPageParams());
  });

  setUp(() {
    mediaCubit = MockMediaCubit();
    when(
      () => mediaCubit.state,
    ).thenAnswer((_) => const MediaState.initial());
  });
  group("initState -", () {
    testWidgets("should invoke the getMediaPerPage when widget is initialized",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();

      //assert
      verify(() => mediaCubit.getMediaPerPage(any())).called(1);
    });
  });

  group("mediaCubit builder -", () {
    testWidgets(
        "should Not show a ListView when medias of currentPageMedias are empty",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets("should show a infoText when listView is empty",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable(
          [
            MediaState.loaded(
              CurrentPageMediasEntity(hasMore: false, medias: []),
            )
          ],
        ),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("no_media_info_text")), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets("should show loadingWidget when state is loading",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable([const MediaState.loading()]),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pump(Durations.short1);

      //assert
      expect(find.byType(LoadingWidget), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });
  });

  group("mediaStateListener -", () {
    testWidgets(
        "should assign the received data to listView when state is loaded",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable([
          MediaState.loaded(
            CurrentPageMediasEntity(
              hasMore: false,
              medias: [FakeMediaEntity()],
            ),
          )
        ]),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(ListView), findsOneWidget);

      //act
      final listView = tester.widget<ListView>(find.byType(ListView));

      //assert
      expect(listView.semanticChildCount, 1);
    });

    testWidgets("should show a failureBottomSheet when state is error",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable([
          MediaState.error(
            InternalFailure(
              message: "message",
              stackTrace: StackTrace.fromString("stackTrace"),
            ),
          )
        ]),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("failure_bottom_sheet")), findsOneWidget);
    });
  });
}

BlocProvider<MediaCubit> _testWidget(MediaCubit mediaCubit) {
  return BlocProvider(
    create: (context) => mediaCubit,
    child: const MaterialApp(
      home: Scaffold(body: MediaPage()),
    ),
  );
}
