import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

class FakeMediaEntity extends Fake implements MediaEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MediaRepository mockMediaRepository;
  late GetSingleMedia getSingleMedia;

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    getSingleMedia = GetSingleMedia(mediaRepository: mockMediaRepository);
  });

  test("should return (MediaEntity) when success", () async {
    //arrange
    when(
      () => mockMediaRepository.getSingleMedia(any()),
    ).thenAnswer((_) async => right(FakeMediaEntity()));

    //act
    final result = await getSingleMedia(1);
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<MediaEntity>());
  });

  test("should return kind of (Failure) when fails to get data", () async {
    //arrange
    when(
      () => mockMediaRepository.getSingleMedia(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await getSingleMedia(1);
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
