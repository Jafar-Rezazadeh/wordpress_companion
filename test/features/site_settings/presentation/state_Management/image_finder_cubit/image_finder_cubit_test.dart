import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/media_service.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

class MockMediaService extends Mock implements MediaService {}

class FakeMediaEntity extends Fake implements MediaEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MediaService mockMediaService;
  late ImageFinderCubit imageFinderCubit;

  setUp(() {
    mockMediaService = MockMediaService();
    imageFinderCubit = ImageFinderCubit(mediaService: mockMediaService);
  });

  group("findImage -", () {
    blocTest<ImageFinderCubit, ImageFinderState>(
      'emits [finding, imageFound] when success',
      setUp: () {
        when(
          () => mockMediaService.getSingleMedia(any()),
        ).thenAnswer((_) async => right(FakeMediaEntity()));
      },
      build: () => imageFinderCubit,
      act: (cubit) => cubit.findImage(1),
      expect: () => [
        isA<ImageFinderState>().having(
          (state) => state.whenOrNull(finding: () => true),
          "is finding state",
          true,
        ),
        isA<ImageFinderState>().having(
          (state) => state.whenOrNull(imageFound: (_) => true),
          "is imageFound state",
          true,
        ),
      ],
    );

    blocTest<ImageFinderCubit, ImageFinderState>(
      'emits [finding, error] when fails',
      setUp: () {
        when(
          () => mockMediaService.getSingleMedia(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => imageFinderCubit,
      act: (cubit) => cubit.findImage(1),
      expect: () => [
        isA<ImageFinderState>().having(
          (state) => state.whenOrNull(finding: () => true),
          "is finding state",
          true,
        ),
        isA<ImageFinderState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });
}
