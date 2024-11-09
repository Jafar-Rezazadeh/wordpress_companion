import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

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

  group("backButton -", () {
    testWidgets("should close the dialog when back_button is tapped",
        (tester) async {
      //arrange
      await _makeTestWidgetAsDialogOpener(tester, imageListCubit);

      //verification
      await _openImageListDialog(tester);

      //act
      await tester.tap(find.byKey(const Key("back_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(ImageSelectorDialog), findsNothing);
    });
  });

  group("SequentialList -", () {
    testWidgets(
        "should invoke the ImageSelector onSelect with the selected media and pop the dialog",
        (tester) async {
      //arrange
      bool isSelectedInvoked = false;

      await _makeTestWidgetAsDialogOpener(
        tester,
        imageListCubit,
        onSelect: (media) => isSelectedInvoked = true,
      );

      await _openImageListDialog(tester);

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
      expect(find.byType(ImageSelectorDialog), findsNothing);
    });
  });
  group("imageListCubit -", () {
    testWidgets("should call the getFirstPage when initState", (tester) async {
      //arrange
      await _testWidget(tester, imageListCubit);
      await tester.pump(Durations.short1);

      //assert
      verify(() => imageListCubit.getFirstPageData()).called(1);
    });

    group("customSearchInput -", () {
      testWidgets("should invoke the searchImage when (onSubmit) is called",
          (tester) async {
        //arrange
        await _testWidget(tester, imageListCubit);
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
        await _testWidget(tester, imageListCubit);
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
        await _testWidget(tester, imageListCubit);
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

        await _testWidget(tester, imageListCubit);
        await tester.pump(Durations.short1);

        //assert
        expect(find.byKey(const Key("failure_dialog")), findsOneWidget);
      });
    });
  });
}

Future<void> _testWidget(
    WidgetTester tester, ImageListCubit imageListCubit) async {
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider(
        create: (context) => imageListCubit,
        child: Builder(
          builder: (context) {
            return Material(
              child: ImageSelectorDialog(
                dialogContext: context,
                onSelect: (media) {},
              ),
            );
          },
        ),
      ),
    ),
  );
}

Future<void> _openImageListDialog(WidgetTester tester) async {
  expect(find.text("open dialog"), findsOneWidget);
  await tester.tap(find.text("open dialog"));
  await tester.pump();
  expect(find.byKey(const Key("image_list_dialog")), findsOneWidget);
}

Future<void> _makeTestWidgetAsDialogOpener(
  WidgetTester tester,
  ImageListCubit imageListCubit, {
  Function(MediaEntity media)? onSelect,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(builder: (context) {
        return Material(
          child: ElevatedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (dialogContext) => BlocProvider(
                  create: (context) => imageListCubit,
                  child: Material(
                    child: ImageSelectorDialog(
                      dialogContext: dialogContext,
                      onSelect: onSelect ?? (media) {},
                    ),
                  ),
                ),
              );
            },
            child: const Text("open dialog"),
          ),
        );
      }),
    ),
  );

  await tester.pumpAndSettle();
}
