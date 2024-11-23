import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockImageListCubit extends MockCubit<ImageListState>
    implements ImageListCubit {}

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  String get sourceUrl => "throw UnimplementedError()";
}

void main() {
  late ImageListCubit imageListCubit;

  setUpAll(() {
    registerFallbackValue(GetMediaPerPageParams());
  });

  setUp(() {
    imageListCubit = MockImageListCubit();
    when(
      () => imageListCubit.state,
    ).thenAnswer((_) => const ImageListState.initial());
  });

  Widget makeTestWidget({
    Function(MediaEntity media)? onSelect,
    Function()? onBack,
  }) {
    return MaterialApp(
      home: Material(
        child: BlocProvider(
          create: (context) => imageListCubit,
          child: ImageSelectorScreen(
            onSelect: onSelect ?? (media) {},
            onBack: onBack ?? () {},
          ),
        ),
      ),
    );
  }

  group("backButton -", () {
    testWidgets("should invoke the onBack when back_button tapped",
        (tester) async {
      //arrange
      bool isBackInvoked = false;
      await tester.pumpWidget(
        makeTestWidget(
          onBack: () {
            isBackInvoked = true;
          },
        ),
      );

      //act
      await tester.tap(find.byKey(const Key("back_button")));
      await tester.pumpAndSettle();

      //assert
      expect(isBackInvoked, true);
    });
  });

  group("imageListCubit -", () {
    testWidgets("should call the getFirstPage when initState", (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget());
      await tester.pump(Durations.short1);

      //assert
      verify(() => imageListCubit.getFirstPageData()).called(1);
    });

    group("customSearchInput -", () {
      testWidgets("should invoke the searchImage when (onSubmit) is called",
          (tester) async {
        //arrange
        await tester.pumpWidget(makeTestWidget());
        await tester.pump(Durations.short1);

        //verification
        expect(find.byType(CustomSearchInput), findsOneWidget);

        //act
        final customSearchInput = tester.widget<CustomSearchInput>(
          find.byType(CustomSearchInput),
        );
        customSearchInput.onSubmit("test");

        //assert
        verify(() => imageListCubit.searchImage(any())).called(1);
      });

      testWidgets("should invoke the getFirstPage when (onClear) is called",
          (tester) async {
        //arrange
        await tester.pumpWidget(makeTestWidget());
        await tester.pump(Durations.short1);

        //verification
        expect(find.byType(CustomSearchInput), findsOneWidget);
        verify(() => imageListCubit.getFirstPageData())
            .called(1); //called on init state

        //act
        final customSearchInput = tester.widget<CustomSearchInput>(
          find.byType(CustomSearchInput),
        );
        customSearchInput.onClear();

        //assert
        verify(() => imageListCubit.getFirstPageData()).called(1);
      });
    });
    group("SequentialList -", () {
      testWidgets("should invoke the onSelect when user tapped on an image",
          (tester) async {
        //arrange
        bool isSelectedInvoked = false;

        await tester.pumpWidget(
          makeTestWidget(
            onSelect: (media) {
              isSelectedInvoked = true;
            },
          ),
        );
        //verification
        expect(find.byType(SequentialImageList), findsOneWidget);

        //act
        final sequentialList = tester.widget<SequentialImageList>(
          find.byType(SequentialImageList),
        );
        sequentialList.onSelect(FakeMediaEntity());
        await tester.pumpAndSettle();

        //assert
        expect(isSelectedInvoked, isTrue);
      });
      testWidgets(
          "should invoke the getNextPageData when onScrolledToBottom is called",
          (tester) async {
        //arrange
        whenListen(
          imageListCubit,
          Stream.fromIterable([
            ImageListState.loaded(
              CurrentPageMedias(hasNextPage: true, medias: []),
            ),
          ]),
        );
        await tester.pumpWidget(makeTestWidget());
        await tester.pump(Durations.short1);

        //verification
        expect(find.byType(SequentialImageList), findsOneWidget);

        //act
        final sequentialList = tester.widget<SequentialImageList>(
          find.byType(SequentialImageList),
        );
        sequentialList.onScrolledToBottom();

        //assert
        verify(() => imageListCubit.getNextPageData()).called(1);
      });
    });
    group("listener -", () {
      testWidgets("should show failure_dialog when state is error",
          (tester) async {
        //arrange
        whenListen(
          imageListCubit,
          Stream.fromIterable([
            ImageListState.error(
              InternalFailure(
                message: "message",
                stackTrace: StackTrace.fromString("stackTraceString"),
              ),
            ),
          ]),
        );

        await tester.pumpWidget(makeTestWidget());
        await tester.pump(Durations.short1);

        //assert
        expect(find.byKey(const Key("failure_dialog")), findsOneWidget);
      });
    });
  });
}
