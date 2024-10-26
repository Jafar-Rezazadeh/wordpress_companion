import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockMediaRepository mockMediaRepository;
  late DeleteMedia deleteMedia;

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    deleteMedia = DeleteMedia(deleteRepository: mockMediaRepository);
  });

  test("should return right(bool) when deletion is successful", () async {
    //arrange
    when(
      () => mockMediaRepository.deleteMedia(any()),
    ).thenAnswer((_) async => right(true));

    //act
    final result = await deleteMedia.call(1);
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, true);
  });

  test("should return kind of (Failure) when some failures occurs", () async {
    //arrange
    when(
      () => mockMediaRepository.deleteMedia(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await deleteMedia.call(1);
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
