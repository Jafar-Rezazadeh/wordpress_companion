import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/upload_file_dialog.dart';

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
      await tester.pump(Durations.short1);

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
      await tester.pump(Durations.short1);

      //assert
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets("should show a infoText when listView is empty when ",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable(
          [
            MediaState.loaded(
              CurrentPageMediasEntity(hasMoreMedias: false, medias: []),
            )
          ],
        ),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pump(Durations.short1);

      //assert
      expect(find.byKey(const Key("no_data_widget")), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets(
        "should show full_screen_loading when (state is loading && page == 1 && listOfMedias.isEmpty)",
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
        "should show a load_on_scroll_widget when (state is loading && listOfMedias.isNotEmpty)",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable([
          MediaState.loaded(CurrentPageMediasEntity(
            hasMoreMedias: true,
            medias: [
              FakeMediaEntity(),
              FakeMediaEntity(),
              FakeMediaEntity(),
              FakeMediaEntity(),
              FakeMediaEntity(),
            ],
          )),
          const MediaState.loading(),
        ]),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pump(Durations.short1);

      //act
      await tester.drag(find.byType(ListView).first, const Offset(0, -5000));
      await tester.pump(Durations.short1);

      //assert
      expect(find.byKey(const Key("load_on_scroll_widget")), findsOneWidget);
    });

    testWidgets(
        "should assign the received data to listView when (state is loaded)",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable([
          MediaState.loaded(
            CurrentPageMediasEntity(
              hasMoreMedias: false,
              medias: [FakeMediaEntity()],
            ),
          )
        ]),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();
      final listViewFinder = find.byType(ListView).first;

      //verification
      expect(listViewFinder, findsOneWidget);

      //act
      final listView = tester.widget<ListView>(listViewFinder);

      //assert
      expect(listView.semanticChildCount, greaterThan(0));
    });

    testWidgets("should show a failureBottomSheet when (state is error)",
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

    testWidgets(
        "should invoke the getMediaPerPage with default params when (state is updated)",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable([const MediaState.updated()]),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();

      //verification
      _verifyGetMediaPerPageCalledWithDefaultParams(mediaCubit, count: 2);
    });
    testWidgets(
        "should invoke the getMediaPerPage with default params when (state is deleted)",
        (tester) async {
      //arrange
      whenListen(
        mediaCubit,
        Stream.fromIterable([const MediaState.deleted(true)]),
      );
      await tester.pumpWidget(_testWidget(mediaCubit));
      await tester.pumpAndSettle();

      //verification
      _verifyGetMediaPerPageCalledWithDefaultParams(mediaCubit, count: 2);
    });
  });

  group("user interaction -", () {
    group("listView -", () {
      testWidgets("should refresh when user drag scroll to top ",
          (tester) async {
        //arrange
        whenListen(
          mediaCubit,
          Stream.fromIterable([
            MediaState.loaded(CurrentPageMediasEntity(
              hasMoreMedias: false,
              medias: [FakeMediaEntity()],
            ))
          ]),
        );
        await tester.pumpWidget(_testWidget(mediaCubit));
        await tester.pumpAndSettle();
        final listViewFinder = find.byType(ListView).first;

        //verification
        expect(listViewFinder, findsOneWidget);

        //act
        await tester.drag(listViewFinder, const Offset(0, -300));
        await tester.pumpAndSettle();

        //assert
        verify(
          () => mediaCubit.getMediaPerPage(
            any(
              that: isA<GetMediaPerPageParams>()
                  .having((params) => params.page == 1, "is page 1", true),
            ),
          ),
        ).called(1);
      });

      testWidgets(
          "should increase the page index of params when listView is scrolled to bottom and hasMore is true",
          (tester) async {
        //arrange
        _setMediaStateLoaded(mediaCubit);
        await tester.pumpWidget(_testWidget(mediaCubit));
        await tester.pumpAndSettle();
        final listViewFinder = find.byType(ListView).first;

        //verification
        expect(listViewFinder, findsOneWidget);
        verify(
          () => mediaCubit.getMediaPerPage(
            any(
              that: isA<GetMediaPerPageParams>().having(
                (params) => params.page == 1,
                "is page 1",
                true,
              ),
            ),
          ),
        ).called(1);

        //act
        await tester.drag(listViewFinder, const Offset(0, -5000));

        //assert
        verify(
          () => mediaCubit.getMediaPerPage(
            any(
              that: isA<GetMediaPerPageParams>().having(
                (params) => params.page == 2,
                "is page 2",
                true,
              ),
            ),
          ),
        ).called(1);
      });
    });

    group("upload_media_button -", () {
      testWidgets("should open upload file dialog when button tapped",
          (tester) async {
        //arrange
        await tester.pumpWidget(_testWidget(mediaCubit));
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("upload_media_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("upload_media_button")));
        await tester.pumpAndSettle();

        //assert
        expect(find.byType(UploadFileDialog), findsOneWidget);
      });
      testWidgets(
          "should invoke the getMediaPerPage of cubit when dialog is closed",
          (tester) async {
        //arrange
        await tester.pumpWidget(_testWidget(mediaCubit));
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("upload_media_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("upload_media_button")));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("back_button")));
        await tester.pumpAndSettle();

        //assert
        verify(() => mediaCubit.getMediaPerPage(any())).called(2);
      });
    });
  });

  group("headerWidget -", () {
    group("searchInput -", () {
      testWidgets(
          "should set the value to search prop of params and call getMedias when onSubmit invoked",
          (tester) async {
        //arrange
        _setMediaStateLoaded(mediaCubit);
        await tester.pumpWidget(_testWidget(mediaCubit));
        await tester.pumpAndSettle();
        final searchInputFinder = find.byType(CustomSearchInput);

        //verification
        expect(searchInputFinder, findsOneWidget);

        //act
        final customSearchInput = tester.widget<CustomSearchInput>(
          searchInputFinder,
        );
        customSearchInput.onSubmit("test");
        await tester.pumpAndSettle();

        //assert
        verify(
          () => mediaCubit.getMediaPerPage(
            any(
              that: isA<GetMediaPerPageParams>().having(
                (params) => params.search == "test",
                "is params.search = test",
                true,
              ),
            ),
          ),
        ).called(1);
      });

      testWidgets(
          "should clear props of params and call the getMedias when onClear invoked",
          (tester) async {
        //arrange
        _setMediaStateLoaded(mediaCubit);
        await tester.pumpWidget(_testWidget(mediaCubit));
        await tester.pumpAndSettle();
        final searchInputFinder = find.byType(CustomSearchInput);

        //verification
        expect(searchInputFinder, findsOneWidget);
        _verifyGetMediaPerPageCalledWithDefaultParams(mediaCubit);

        //act
        final customSearchInput =
            tester.widget<CustomSearchInput>(searchInputFinder);
        customSearchInput.onClear();
        await tester.pumpAndSettle();

        //assert
        _verifyGetMediaPerPageCalledWithDefaultParams(mediaCubit);
      });
    });

    group("mediaFilterButton -", () {
      testWidgets(
          "should set filters to params when onApply invoked and getMedias ",
          (tester) async {
        //arrange
        _setMediaStateLoaded(mediaCubit);
        await tester.pumpWidget(_testWidget(mediaCubit));

        //verification
        final mediaFilterButtonFinder = find.byType(MediaFilterButton);
        expect(mediaFilterButtonFinder, findsOneWidget);

        //act
        final mediaFilterButton = tester.widget<MediaFilterButton>(
          mediaFilterButtonFinder,
        );
        mediaFilterButton.onApply(
          (after: "after-date", before: "before-date", type: MediaType.image),
        );
        await tester.pumpAndSettle();

        //assert
        verify(
          () => mediaCubit.getMediaPerPage(
            any(
              that: isA<GetMediaPerPageParams>().having(
                (params) =>
                    params.after == "after-date" &&
                    params.before == "before-date" &&
                    params.type == MediaType.image,
                "is params set",
                true,
              ),
            ),
          ),
        ).called(1);
      });

      testWidgets(
          "should set params to default and call getMedias when onClear invoked",
          (tester) async {
        //arrange
        _setMediaStateLoaded(mediaCubit);
        await tester.pumpWidget(_testWidget(mediaCubit));

        //verification
        final mediaFilterButtonFinder = find.byType(MediaFilterButton);
        expect(mediaFilterButtonFinder, findsOneWidget);
        _verifyGetMediaPerPageCalledWithDefaultParams(mediaCubit);

        //act
        final mediaFilterButton = tester.widget<MediaFilterButton>(
          mediaFilterButtonFinder,
        );
        mediaFilterButton.onClear();
        await tester.pumpAndSettle();

        //assert
        _verifyGetMediaPerPageCalledWithDefaultParams(mediaCubit);
      });
    });
  });

  group("infiniteListView -", () {
    testWidgets(
        "should set (page = 1 and search=null) of params and call getMedias when onRefresh invoked",
        (tester) async {
      //arrange
      _setMediaStateLoaded(mediaCubit);
      await tester.pumpWidget(_testWidget(mediaCubit));

      //verification
      final infiniteListViewFinder = find.byType(InfiniteListView<MediaEntity>);
      expect(infiniteListViewFinder, findsOneWidget);

      // setting the other params
      final mediaFilterButton = tester.widget<MediaFilterButton>(
        find.byType(MediaFilterButton),
      );
      mediaFilterButton.onApply(
        (after: "after-date", before: "before-date", type: MediaType.video),
      );
      await tester.pumpAndSettle();

      //act
      final infiniteListView = tester.widget<InfiniteListView<MediaEntity>>(
        infiniteListViewFinder,
      );
      infiniteListView.onRefresh();
      await tester.pumpAndSettle();

      //assert
      verify(
        () => mediaCubit.getMediaPerPage(
          any(
            that: isA<GetMediaPerPageParams>().having(
              (params) =>
                  params.page == 1 &&
                  params.search == null &&
                  params.type == MediaType.video,
              "is params set",
              true,
            ),
          ),
        ),
      ).called(2);
    });
  });
}

void _verifyGetMediaPerPageCalledWithDefaultParams(MediaCubit mediaCubit,
    {int count = 1}) {
  return verify(
    () => mediaCubit.getMediaPerPage(
      any(
        that: isA<GetMediaPerPageParams>().having(
          (params) => _defaultParams(params),
          "is params default",
          true,
        ),
      ),
    ),
  ).called(count);
}

bool _defaultParams(GetMediaPerPageParams params) {
  return params.search == null &&
      params.page == 1 &&
      params.perPage == 10 &&
      params.after == null &&
      params.before == null &&
      params.type == null;
}

void _setMediaStateLoaded(MediaCubit mediaCubit) {
  return whenListen(
    mediaCubit,
    Stream.fromIterable([
      MediaState.loaded(CurrentPageMediasEntity(
        hasMoreMedias: true,
        medias: [
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
          FakeMediaEntity(),
        ],
      ))
    ]),
  );
}

Widget _testWidget(MediaCubit mediaCubit) {
  return BlocProvider(
    create: (context) => mediaCubit,
    child: const ScreenUtilInit(
      child: MaterialApp(
        home: Scaffold(body: MediaPage()),
      ),
    ),
  );
}
