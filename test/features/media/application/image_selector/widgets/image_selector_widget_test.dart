import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
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
  }) {
    return GetMaterialApp(
      home: Builder(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) async {
            final result = await Get.to(BlocProvider(
              create: (context) => imageListCubit,
              child: const Material(child: ImageSelectorScreen()),
            ));
            onSelect != null ? onSelect(result) : null;
          },
        );
        return Container();
      }),
    );
  }

  group("backButton -", () {
    testWidgets("should pop the screen when back_button tapped",
        (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget());
      await tester.pumpAndSettle();
      // verification
      expect(find.byType(ImageSelectorScreen), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("back_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(ImageSelectorScreen), findsNothing);
    });
  });

  group("imageListCubit -", () {
    testWidgets("should call the getFirstPage when initState", (tester) async {
      //arrange
      await tester.pumpWidget(makeTestWidget());
      await tester.pumpAndSettle();

      //assert
      verify(() => imageListCubit.getFirstPageData()).called(1);
    });

    group("customSearchInput -", () {
      testWidgets("should invoke the searchImage when (onSubmit) is called",
          (tester) async {
        //arrange
        await tester.pumpWidget(makeTestWidget());
        await tester.pumpAndSettle();

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
        await tester.pumpAndSettle();

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
      testWidgets(
          "should get the selected media as back result when user tapped on an image",
          (tester) async {
        //arrange
        MediaEntity? result;

        await tester.pumpWidget(
          makeTestWidget(
            onSelect: (media) {
              result = media;
            },
          ),
        );
        await tester.pumpAndSettle();

        //verification
        expect(find.byType(SequentialImageList), findsOneWidget);

        //act
        final sequentialList = tester.widget<SequentialImageList>(
          find.byType(SequentialImageList),
        );
        sequentialList.onSelect(FakeMediaEntity());
        await tester.pumpAndSettle();

        //assert
        expect(result, isNotNull);
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
        await tester.pumpAndSettle();

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
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("failure_dialog")), findsOneWidget);
      });
    });
  });
}
