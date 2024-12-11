import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class MockImageListCubit extends MockCubit<ImageListState>
    implements ImageListCubit {}

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 20;

  @override
  String get sourceUrl => "link";
}

void main() {
  late ImageListCubit imageListCubit;

  setUp(() {
    imageListCubit = MockImageListCubit();
    when(
      () => imageListCubit.state,
    ).thenReturn(const ImageListState.initial());
  });

  makeTestWidget({
    required Function(MediaEntity image) onImageSelected,
    required VoidCallback onClearImage,
  }) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: imageSelectorRoute,
          page: () => BlocProvider(
            create: (context) => imageListCubit,
            child: const Scaffold(
              body: ImageSelectorScreen(),
            ),
          ),
        )
      ],
      home: Material(
        child: FeaturedImageInput(
          onImageSelected: onImageSelected,
          onClearImage: onClearImage,
        ),
      ),
    );
  }

  testWidgets("should go to imageSelectorRoute when imageSelector is tapped",
      (tester) async {
    //arrange
    onImageSelected(MediaEntity media) {}
    await tester.pumpWidget(
      makeTestWidget(
        onImageSelected: onImageSelected,
        onClearImage: () {},
      ),
    );
    await tester.pumpAndSettle();

    //verification
    final imageSelectorFinder = find.byKey(const Key("image_selector"));
    expect(imageSelectorFinder, findsOneWidget);

    //act
    await tester.tap(imageSelectorFinder);
    await tester.pumpAndSettle();

    //assert
    expect(find.byType(ImageSelectorScreen), findsOneWidget);
  });

  testWidgets(
      "should invoke the onImageSelect when imageSelector onSelect invoked and return the selected image",
      (tester) async {
    //arrange
    MediaEntity? media;
    await tester.pumpWidget(
      makeTestWidget(
        onImageSelected: (image) {
          media = image;
        },
        onClearImage: () {},
      ),
    );
    await tester.pumpAndSettle();

    //verification
    final imageSelectorFinder = find.byKey(const Key("image_selector"));
    expect(imageSelectorFinder, findsOneWidget);

    //act
    await tester.tap(imageSelectorFinder);
    await tester.pumpAndSettle();

    expect(find.byType(ImageSelectorScreen), findsOneWidget);

    tester
        .widget<SequentialImageList>(find.byType(SequentialImageList))
        .onSelect(FakeMediaEntity());

    await tester.pumpAndSettle();

    //assert
    expect(media, isNotNull);
  });

  testWidgets("should invoke onClearImage when remove_image is tapped",
      (tester) async {
    //arrange
    bool isInvoked = false;
    await tester.pumpWidget(
      makeTestWidget(
        onImageSelected: (_) {},
        onClearImage: () {
          isInvoked = true;
        },
      ),
    );

    //verification
    expect(find.byKey(const Key("remove_image")), findsOneWidget);

    //act
    await tester.tap(find.byKey(const Key("remove_image")));

    //assert
    expect(isInvoked, true);
  });
}
