import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/domain/use_cases/update_media.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

class FakeUpdateMediaParams extends Fake implements UpdateMediaParams {}

class FakeMediaEntity extends Fake implements MediaEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockMediaRepository mockMediaRepository;
  late UpdateMedia updateMedia;

  setUpAll(() {
    registerFallbackValue(FakeUpdateMediaParams());
  });

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    updateMedia = UpdateMedia(mediaRepository: mockMediaRepository);
  });

  group("useCase -", () {
    test("should return updated media as (MediaEntity) when success to update",
        () async {
      //arrange
      when(
        () => mockMediaRepository.updateMedia(any()),
      ).thenAnswer((_) async => right(FakeMediaEntity()));

      //act
      final result = await updateMedia.call(FakeUpdateMediaParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<MediaEntity>());
    });

    test("should return kind of (Failure) when fails to update", () async {
      //arrange
      when(
        () => mockMediaRepository.updateMedia(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await updateMedia.call(FakeUpdateMediaParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });

  group("params -", () {
    test("should include the id in props ", () {
      //arrange
      const params = UpdateMediaParams(
        id: 1,
        altText: "altText",
        title: "title",
        caption: "caption",
        description: "description",
      );

      //act
      final props = params.props;

      //assert
      expect(props, [1]);
    });
  });
}
