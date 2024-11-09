import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_entity.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockImageListCubit extends MockCubit<ImageListState>
    implements ImageListCubit {}

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 1;

  @override
  String get sourceUrl => "source";
}

void main() {
  late ImageListCubit imageListCubit;
  GetIt getIt = GetIt.instance;

  setUp(() {
    imageListCubit = MockImageListCubit();
    when(
      () => imageListCubit.state,
    ).thenAnswer((invocation) => const ImageListState.initial());
    getIt.registerSingleton<ImageListCubit>(imageListCubit);
  });

  tearDown(() {
    getIt.reset();
  });

  group("image input -", () {
    testWidgets("should open ImageSelectorDialog when taped on the imageBox",
        (tester) async {
      //arrange
      await _makeTestWidget(tester);

      //act
      await _openImageSelectorDialog(tester);

      //assert
      expect(find.byKey(const Key("select_media_dialog")), findsOneWidget);
    });

    testWidgets(
        "should show an image widget when an image is selected via ImageSelectorDialog ",
        (tester) async {
      //arrange
      await _makeTestWidget(tester);
      await _openImageSelectorDialog(tester);

      //verification
      expect(find.byType(Image), findsNothing);
      expect(find.byType(ImageSelectorDialog), findsOneWidget);

      //act

      tester
          .widget<ImageSelectorDialog>(find.byType(ImageSelectorDialog))
          .onSelect(FakeMediaEntity());
      await tester.pump();

      //assert
      expect(find.byType(Image), findsOneWidget);
    });
  });

  group("Image -", () {
    testWidgets("should show error icon when Image is fails", (tester) async {
      //arrange
      await _makeTestWidget(tester);
      await _openImageSelectorDialog(tester);

      //verification
      tester
          .widget<ImageSelectorDialog>(find.byType(ImageSelectorDialog))
          .onSelect(FakeMediaEntity());
      await tester.pump();
      expect(find.byType(Image), findsOneWidget);
      await tester.pumpAndSettle();

      // bcs mockNetworkImageFor mock the image fetch request and return fails
      expect(find.byKey(const Key("error_icon")), findsOneWidget);
    });
  });
}

Future<void> _makeTestWidget(WidgetTester tester) async {
  await mockNetworkImagesFor(() async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SiteIconInput(
            onSelect: (value) {},
          ),
        ),
      ),
    );
  });

  await tester.pumpAndSettle();
}

Future<void> _openImageSelectorDialog(WidgetTester tester) async {
  //act
  await tester.tap(find.byKey(const Key("site_icon_input")));

  await tester.pumpAndSettle();
}
