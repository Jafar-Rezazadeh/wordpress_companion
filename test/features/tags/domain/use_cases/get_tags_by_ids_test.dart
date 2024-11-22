import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class MockTagsRepository extends Mock implements TagsRepository {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockTagsRepository mockTagsRepository;
  late GetTagsByIds getTagsByIds;

  setUp(() {
    mockTagsRepository = MockTagsRepository();
    getTagsByIds = GetTagsByIds(tagsRepository: mockTagsRepository);
  });

  test("should return (List<TagEntity>) when success", () async {
    //arrange
    when(
      () => mockTagsRepository.getTagsByIds(any()),
    ).thenAnswer((_) async => right([]));

    //act
    final result = await getTagsByIds([12]);
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<List<TagEntity>>());
  });

  test("should return kind of(Failure) when fails", () async {
    //arrange
    when(
      () => mockTagsRepository.getTagsByIds(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await getTagsByIds([42, 5]);
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
