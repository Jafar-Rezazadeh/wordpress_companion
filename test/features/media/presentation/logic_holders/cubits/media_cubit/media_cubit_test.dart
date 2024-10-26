import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockDeleteMedia extends Mock implements DeleteMedia {}

class MockGetMediaPerPage extends Mock implements GetMediaPerPage {}

class MockUpdateMedia extends Mock implements UpdateMedia {}

class FakeFailure extends Fake implements Failure {}

class FakeMediaEntity extends Fake implements MediaEntity {}

class FakeCurrentPageMediasEntity extends Fake
    implements CurrentPageMediasEntity {}

void main() {
  late MockDeleteMedia mockDeleteMedia;
  late MockGetMediaPerPage mockGetMediaPerPage;
  late MockUpdateMedia mockUpdateMedia;
  late MediaCubit mediaCubit;

  const updateParams = UpdateMediaParams(
    id: 1,
    altText: "altText",
    title: "title",
    caption: "caption",
    description: "description",
  );
  final getMediasParams = GetMediaPerPageParams();

  setUp(() {
    mockDeleteMedia = MockDeleteMedia();
    mockGetMediaPerPage = MockGetMediaPerPage();
    mockUpdateMedia = MockUpdateMedia();
    mediaCubit = MediaCubit(
      deleteMedia: mockDeleteMedia,
      getMediaPerPage: mockGetMediaPerPage,
      updateMedia: mockUpdateMedia,
    );
  });

  group("deleteMedia -", () {
    blocTest<MediaCubit, MediaState>(
      'emits [loading, deleted] when deletion happened',
      setUp: () {
        when(
          () => mockDeleteMedia.call(any()),
        ).thenAnswer((_) async => right(true));
      },
      build: () => mediaCubit,
      act: (cubit) => cubit.deleteMedia(2),
      expect: () => [
        isA<MediaState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<MediaState>().having(
          (state) => state.whenOrNull(deleted: (_) => true),
          'is deleted state',
          true,
        ),
      ],
      verify: (_) => verify(() => mockDeleteMedia.call(any())).called(1),
    );

    blocTest<MediaCubit, MediaState>(
      'emits [loading, error] when a failure occurred',
      setUp: () {
        when(
          () => mockDeleteMedia.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => mediaCubit,
      act: (cubit) => cubit.deleteMedia(2),
      expect: () => [
        isA<MediaState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<MediaState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );
  });

  group("updateMedia -", () {
    blocTest<MediaCubit, MediaState>(
      'emits [loading, updated] when success to update',
      setUp: () {
        when(
          () => mockUpdateMedia.call(updateParams),
        ).thenAnswer((_) async => right(FakeMediaEntity()));
      },
      build: () => mediaCubit,
      act: (cubit) => cubit.updateMedia(updateParams),
      expect: () => [
        isA<MediaState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<MediaState>().having(
          (state) => state.whenOrNull(updated: () => true),
          'is updated state',
          true,
        ),
      ],
    );

    blocTest<MediaCubit, MediaState>(
      'emits [loading, error] when a failure occurred',
      setUp: () {
        when(
          () => mockUpdateMedia.call(updateParams),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => mediaCubit,
      act: (cubit) => cubit.updateMedia(updateParams),
      expect: () => [
        isA<MediaState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<MediaState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );
  });

  group("getMediaPerPage -", () {
    blocTest<MediaCubit, MediaState>(
      'emits [loading, loaded] when success to get data',
      setUp: () {
        when(
          () => mockGetMediaPerPage.call(getMediasParams),
        ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));
      },
      build: () => mediaCubit,
      act: (cubit) => cubit.getMediaPerPage(getMediasParams),
      expect: () => [
        isA<MediaState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<MediaState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          'is loaded state',
          true,
        ),
      ],
    );

    blocTest<MediaCubit, MediaState>(
      'emits [loading, error] when a failure occurred',
      setUp: () {
        when(
          () => mockGetMediaPerPage.call(getMediasParams),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => mediaCubit,
      act: (cubit) => cubit.getMediaPerPage(getMediasParams),
      expect: () => [
        isA<MediaState>().having(
          (state) => state.whenOrNull(loading: () => true),
          'is loading state',
          true,
        ),
        isA<MediaState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );
  });
}
