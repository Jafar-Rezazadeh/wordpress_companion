import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockMediaRepository mockMediaRepository;
  late GetAllMedia getAllMedia;

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    getAllMedia = GetAllMedia(mediaRepository: mockMediaRepository);
  });

  test("should return (List<MediaEntity>) when success", () async {
    //arrange
    when(
      () => mockMediaRepository.getAllMedia(),
    ).thenAnswer((_) async => right(<MediaEntity>[]));

    //act
    final result = await getAllMedia.call(NoParams());
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<List<MediaEntity>>());
  });

  test("should return kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockMediaRepository.getAllMedia(),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await getAllMedia.call(NoParams());
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
