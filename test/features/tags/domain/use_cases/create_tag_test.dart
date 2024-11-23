import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class MockTagsRepository extends Mock implements TagsRepository {}

class FakeTagEntity extends Fake implements TagEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockTagsRepository mockTagsRepository;
  late CreateTag createTag;

  setUp(() {
    mockTagsRepository = MockTagsRepository();
    createTag = CreateTag(tagsRepository: mockTagsRepository);
  });

  test("should return created tag as (TagEntity) when success", () async {
    //arrange
    when(
      () => mockTagsRepository.createTag(any()),
    ).thenAnswer((_) async => right(FakeTagEntity()));

    //act
    final result = await createTag("saw");
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<TagEntity>());
  });

  test("should return kind of(Failure) when fails", () async {
    //arrange
    when(
      () => mockTagsRepository.createTag(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await createTag("ge");
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
