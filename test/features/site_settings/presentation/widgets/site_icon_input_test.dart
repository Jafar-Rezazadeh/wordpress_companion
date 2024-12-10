import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockImageListCubit extends MockCubit<ImageListState>
    implements ImageListCubit {}

class MockImageFinderCubit extends MockCubit<ImageFinderState>
    implements ImageFinderCubit {}

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 1;

  @override
  String get sourceUrl => "source";
}

void main() {
  late ImageListCubit imageListCubit;
  late ImageFinderCubit imageFinderCubit;
  GetIt getIt = GetIt.instance;

  setUp(() {
    imageListCubit = MockImageListCubit();
    when(
      () => imageListCubit.state,
    ).thenAnswer((_) => const ImageListState.initial());

    imageFinderCubit = MockImageFinderCubit();
    _initImageFinderCubit(imageFinderCubit);
  });

  tearDown(() {
    getIt.reset();
  });

  Future<void> makeTestWidget(WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        GetMaterialApp(
          getPages: [
            GetPage(
              name: imageSelectorRoute,
              page: () => BlocProvider(
                create: (context) => imageListCubit,
                child: const Material(
                  child: ImageSelectorScreen(),
                ),
              ),
            )
          ],
          home: Material(
            child: BlocProvider(
              create: (context) => imageFinderCubit,
              child: SiteIconInput(
                initialImageId: 2,
                onSelect: (value) {},
              ),
            ),
          ),
        ),
      );
    });

    await tester.pumpAndSettle();
  }

  group("imageFinderCubit -", () {
    testWidgets("should invoke the findImage when widget init", (tester) async {
      //arrange
      await makeTestWidget(tester);

      //verification
      verify(() => imageFinderCubit.findImage(any())).called(1);
    });
    group("listener -", () {
      testWidgets("should set the selected image when state is imageFound",
          (tester) async {
        //arrange
        whenListen(
          imageFinderCubit,
          Stream.fromIterable([
            ImageFinderState.imageFound(FakeMediaEntity()),
          ]),
        );
        await makeTestWidget(tester);

        //assert
        expect(find.byType(Image), findsOneWidget);
      });
    });
  });

  group("image input -", () {
    testWidgets(
        "should go to the ImageSelectorScreen when taped on the imageBox",
        (tester) async {
      //arrange
      await makeTestWidget(tester);

      //act
      await _openImageSelectorDialog(tester);

      //assert
      expect(find.byType(ImageSelectorScreen), findsOneWidget);
    });

    testWidgets(
        "should show an image widget when an image is selected via ImageSelectorDialog ",
        (tester) async {
      //arrange
      await makeTestWidget(tester);
      await _openImageSelectorDialog(tester);

      //verification
      expect(find.byType(Image), findsNothing);
      expect(find.byType(ImageSelectorScreen), findsOneWidget);

      //act

      tester
          .widget<SequentialImageList>(find.byType(SequentialImageList))
          .onSelect(FakeMediaEntity());

      await tester.pumpAndSettle();

      //assert
      expect(find.byType(Image), findsOneWidget);
    });
  });

  group("Image -", () {
    testWidgets("should show error icon when Image is fails", (tester) async {
      //arrange
      await makeTestWidget(tester);
      await _openImageSelectorDialog(tester);

      //verification
      tester
          .widget<SequentialImageList>(find.byType(SequentialImageList))
          .onSelect(FakeMediaEntity());

      await tester.pump();
      expect(find.byType(Image), findsOneWidget);
      await tester.pumpAndSettle();

      // bcs mockNetworkImageFor mock the image fetch request and return fails
      expect(find.byKey(const Key("error_icon")), findsOneWidget);
    });
  });
}

void _initImageFinderCubit(ImageFinderCubit imageFinderCubit) {
  when(
    () => imageFinderCubit.state,
  ).thenAnswer((invocation) => const ImageFinderState.initial());
}

Future<void> _openImageSelectorDialog(WidgetTester tester) async {
  //act
  await tester.tap(find.byKey(const Key("site_icon_input")));

  await tester.pumpAndSettle();
}
