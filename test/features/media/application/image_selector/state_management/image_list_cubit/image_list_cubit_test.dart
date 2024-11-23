import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/media_service.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaService extends Mock implements MediaService {}

class FakeMediaEntity extends Fake implements MediaEntity {}

class FakeCurrentPageMediasEntity extends Fake implements CurrentPageMedias {
  @override
  bool get hasNextPage => true;
  @override
  List<MediaEntity> get medias => [
        FakeMediaEntity(),
        FakeMediaEntity(),
        FakeMediaEntity(),
      ];
}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockMediaService mockMediaService;
  late ImageListCubit imageListCubit;

  setUpAll(() {
    registerFallbackValue(GetMediaPerPageParams());
  });

  setUp(() {
    mockMediaService = MockMediaService();
    imageListCubit = ImageListCubit(mediaService: mockMediaService);
  });

  group("getFirstPageData -", () {
    blocTest<ImageListCubit, ImageListState>(
      'emits [loading, loaded] with default params',
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.getFirstPageData(),
      expect: () => [
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          'is loaded state',
          true,
        ),
      ],
      verify: (_) => verify(
        () => mockMediaService.getMediaPerPage(any(
          that: isA<GetMediaPerPageParams>().having(
            (params) =>
                params.page == 1 &&
                params.perPage == 100 &&
                params.search == null,
            "is default params",
            true,
          ),
        )),
      ),
    );

    blocTest<ImageListCubit, ImageListState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.getFirstPageData(),
      expect: () => [
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<ImageListState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );

    blocTest<ImageListCubit, ImageListState>(
      'should resetting params to default after getNextPageData called',
      seed: () => ImageListState.loaded(FakeCurrentPageMediasEntity()),
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit
        ..getNextPageData()
        ..getFirstPageData(),
      verify: (bloc) {
        verify(
          () => mockMediaService.getMediaPerPage(any(
            that: isA<GetMediaPerPageParams>().having(
              (params) =>
                  params.page == 2 &&
                  params.perPage == 100 &&
                  params.search == null,
              "is page == 2",
              true,
            ),
          )),
        );

        verify(
          () => mockMediaService.getMediaPerPage(any(
            that: isA<GetMediaPerPageParams>().having(
              (params) => params.page == 1,
              "is page == 1",
              true,
            ),
          )),
        );
      },
    );
  });

  group("getNextPageData - ", () {
    blocTest<ImageListCubit, ImageListState>(
      'emits [loading, loaded] when success and should add the new value to previous data',
      seed: () => ImageListState.loaded(FakeCurrentPageMediasEntity()),
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.getNextPageData(),
      expect: () => [
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        )
      ],
      verify: (cubit) {
        final mediaLength = cubit.state.maybeWhen(
          loaded: (currentPageMedias) => (currentPageMedias.medias.length),
          orElse: () => 0,
        );
        expect(mediaLength, 6);
      },
    );

    blocTest<ImageListCubit, ImageListState>(
      'emits [loading , error] when fails',
      seed: () => ImageListState.loaded(FakeCurrentPageMediasEntity()),
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.getNextPageData(),
      expect: () => [
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ImageListState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );

    blocTest<ImageListCubit, ImageListState>(
      'Does Nothing when the current state is loading',
      seed: () => const ImageListState.loading(),
      setUp: () {},
      build: () => imageListCubit,
      act: (cubit) => cubit.getNextPageData(),
      expect: () => [],
      verify: (bloc) => verifyNever(
        () => mockMediaService.getMediaPerPage(any()),
      ),
    );

    blocTest<ImageListCubit, ImageListState>(
      'Does NoThing when hasNextPage is false',
      seed: () => ImageListState.loaded(
          CurrentPageMedias(hasNextPage: false, medias: [])),
      setUp: () {},
      build: () => imageListCubit,
      act: (cubit) => cubit.getNextPageData(),
      expect: () => [],
      verify: (bloc) => verifyNever(
        () => mockMediaService.getMediaPerPage(any()),
      ),
    );

    blocTest<ImageListCubit, ImageListState>(
      'should get firstPage when pervious state is not loaded',
      seed: () => const ImageListState.initial(),
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.getNextPageData(),
      verify: (bloc) => verify(
        () => mockMediaService.getMediaPerPage(any(
          that: isA<GetMediaPerPageParams>().having(
            (params) => params.page == 1,
            "is page == 1",
            true,
          ),
        )),
      ),
    );

    blocTest<ImageListCubit, ImageListState>(
      'should increase the params page when pervious state is loaded',
      seed: () => ImageListState.loaded(FakeCurrentPageMediasEntity()),
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => imageListCubit,
      act: (cubit) async {
        await cubit.getFirstPageData();
        await cubit.getNextPageData();
      },
      verify: (bloc) => verify(
        () => mockMediaService.getMediaPerPage(any(
          that: isA<GetMediaPerPageParams>().having(
            (params) => params.page == 2 && params.perPage == 100,
            "is page increased",
            true,
          ),
        )),
      ),
    );
  });

  group("searchImage - ", () {
    blocTest<ImageListCubit, ImageListState>(
      'emits [loading, loaded] when called',
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.searchImage("test"),
      expect: () => [
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        ),
      ],
    );

    blocTest<ImageListCubit, ImageListState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.searchImage("test"),
      expect: () => [
        isA<ImageListState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<ImageListState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );

    blocTest<ImageListCubit, ImageListState>(
      'Does Nothing when given value is empty',
      setUp: () {},
      build: () => imageListCubit,
      act: (cubit) => cubit.searchImage(""),
      expect: () => [],
      verify: (_) => verifyNever(() => mockMediaService.getMediaPerPage(any())),
    );

    blocTest<ImageListCubit, ImageListState>(
      'should set the expected params when calling mediaService',
      setUp: () {
        when(
          () => mockMediaService.getMediaPerPage(any()),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => imageListCubit,
      act: (cubit) => cubit.searchImage("test"),
      verify: (_) => verify(
        () => mockMediaService.getMediaPerPage(
          any(
            that: isA<GetMediaPerPageParams>().having(
              (params) => params.search == "test",
              "is search == test",
              true,
            ),
          ),
        ),
      ),
    );
  });
}
