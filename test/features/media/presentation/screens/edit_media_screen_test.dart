import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaCubit extends MockCubit<MediaState> implements MediaCubit {}

class FakeUpdateMediaParams extends Fake implements UpdateMediaParams {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<dynamic> {}

void main() {
  final mediaEntity = MediaEntity(
    id: 2,
    date: DateTime(2024),
    guid: "guid",
    modified: DateTime(2024),
    slug: "slug",
    status: "status",
    type: "type",
    link: "link",
    title: "title",
    author: 1,
    featuredMedia: 1,
    commentStatus: "open",
    pingStatus: "pingStatus",
    template: "template",
    permalinkTemplate: "permalinkTemplate",
    generatedSlug: "generatedSlug",
    classList: const [],
    description: "description",
    caption: "caption",
    altText: "altText",
    mediaType: "mediaType",
    mimeType: "mimeType",
    mediaDetails: const MediaDetailsEntity(
      fileSize: 120,
      height: 10,
      width: 20,
    ),
    post: null,
    sourceUrl: "sourceUrl",
    authorName: "authorName",
  );
  late MediaCubit mediaCubit;
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() {
    registerFallbackValue(FakeUpdateMediaParams());
    registerFallbackValue(MockRoute());
  });

  setUp(() {
    mediaCubit = MockMediaCubit();
    when(() => mediaCubit.state).thenAnswer((_) => const MediaState.initial());
    mockNavigatorObserver = MockNavigatorObserver();
  });

  group("mediaCubit -", () {
    testWidgets("should pop the context when state is updated", (tester) async {
      //arrange

      whenListen(
        mediaCubit,
        Stream.fromIterable([const MediaState.updated()]),
      );
      await tester.pumpWidget(
        _pushedOnStackTest(mediaCubit, mediaEntity, mockNavigatorObserver),
      );
      await tester.pumpAndSettle();

      //verification
      expect(find.text("Push"), findsOneWidget);

      // act
      await tester.tap(find.text('Push'));
      await tester.pumpAndSettle();

      //assert
      verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
    });
  });

  group("user interaction -", () {
    testWidgets(
        "should show a snackBar that says link copied when user tap on copy_link_button",
        (tester) async {
      //arrange
      await tester.pumpWidget(_makeTestWidget(mediaCubit, mediaEntity));
      await tester.pumpAndSettle();

      //verification
      await tester.scrollUntilVisible(
        find.byKey(const Key("copy_link_button")),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.byKey(const Key("copy_link_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("copy_link_button")));
      await tester.pump();

      //assert
      expect(find.byType(SnackBar), findsOneWidget);
    });

    group("on Save -", () {
      testWidgets(
          "should call updateMedia of mediaCubit when save_button is pressed",
          (tester) async {
        //arrange
        await tester.pumpWidget(_makeTestWidget(mediaCubit, mediaEntity));
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("save_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("save_button")));
        await tester.pump();

        //assert
        verify(() => mediaCubit.updateMedia(any())).called(1);
      });

      testWidgets(
          "should update the media with given input value when on save is tapped",
          (tester) async {
        //arrange
        await tester.pumpWidget(_makeTestWidget(mediaCubit, mediaEntity));
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("save_button")), findsOneWidget);
        await tester.scrollUntilVisible(
          find.byType(Form),
          500,
          scrollable: find.byType(Scrollable).first,
        );
        final inputsFinder = find.byType(TextFormField);
        expect(inputsFinder, findsExactly(4));

        //act
        await tester.enterText(inputsFinder.at(0), "test");
        await tester.enterText(inputsFinder.at(1), "test");
        await tester.enterText(inputsFinder.at(2), "test");
        await tester.enterText(inputsFinder.at(3), "test");

        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("save_button")));
        await tester.pump();

        //assert
        verify(
          () => mediaCubit.updateMedia(
            any(
              that: isA<UpdateMediaParams>().having(
                (params) =>
                    params.altText == "test" &&
                    params.caption == "test" &&
                    params.description == "test" &&
                    params.title == "test",
                "is params updated",
                true,
              ),
            ),
          ),
        ).called(1);
      });
    });

    group("on delete -", () {
      testWidgets(
          "should invoke the deleteMedia of mediaCubit when delete confirmed",
          (tester) async {
        //arrange
        await tester.pumpWidget(_makeTestWidget(mediaCubit, mediaEntity));
        await tester.pumpAndSettle();

        //verification
        expect(find.byKey(const Key("delete_button")), findsOneWidget);

        //act
        await tester.tap(find.byKey(const Key("delete_button")));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("confirm_button")));
        await tester.pumpAndSettle();

        //assert
        verify(() => mediaCubit.deleteMedia(any())).called(1);
      });
    });
  });
}

Widget _pushedOnStackTest(MediaCubit mediaCubit, MediaEntity mediaEntity,
    MockNavigatorObserver mockNavigatorObserver) {
  return ScreenUtilInit(
    child: BlocProvider(
      create: (context) => mediaCubit,
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          EditMediaScreen(mediaEntity: mediaEntity),
                    ),
                  );
                },
                child: const Text('Push'),
              );
            },
          ),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    ),
  );
}

Widget _makeTestWidget(
  MediaCubit mediaCubit,
  MediaEntity mediaEntity,
) {
  return BlocProvider(
    create: (context) => mediaCubit,
    child: ScreenUtilInit(
      child: MaterialApp(
        home: EditMediaScreen(mediaEntity: mediaEntity),
      ),
    ),
  );
}
