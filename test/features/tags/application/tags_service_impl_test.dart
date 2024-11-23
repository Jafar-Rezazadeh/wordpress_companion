import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/tags/application/tags_service_impl.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class MockCreateTag extends Mock implements CreateTag {}

class MockSearchTag extends Mock implements SearchTag {}

class MockGetTagsByIds extends Mock implements GetTagsByIds {}

class FakeTagEntity extends Fake implements TagEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockCreateTag mockCreateTag;
  late MockSearchTag mockSearchTag;
  late MockGetTagsByIds mockGetTagsByIds;
  late TagsServiceImpl tagsServiceImpl;

  setUp(() {
    mockCreateTag = MockCreateTag();
    mockSearchTag = MockSearchTag();
    mockGetTagsByIds = MockGetTagsByIds();
    tagsServiceImpl = TagsServiceImpl(
      createTag: mockCreateTag,
      getTagsByIds: mockGetTagsByIds,
      searchTag: mockSearchTag,
    );
  });

  group("createTag -", () {
    test("should return (TagEntity) when success", () async {
      //arrange
      when(
        () => mockCreateTag.call(any()),
      ).thenAnswer((_) async => right(FakeTagEntity()));

      //act
      final result = await tagsServiceImpl.createTag("name");
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<TagEntity>());
    });

    test("should return kind of (Failure) when fails", () async {
      //arrange
      when(
        () => mockCreateTag.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await tagsServiceImpl.createTag("name");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });

  group("getTagsByIds -", () {
    test("should return (List<TagEntity>) when success", () async {
      //arrange
      when(
        () => mockGetTagsByIds.call(any()),
      ).thenAnswer((_) async => right([]));

      //act
      final result = await tagsServiceImpl.getTagsByIds([5]);
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<List<TagEntity>>());
    });

    test("should return kind of (Failure) when fails", () async {
      //arrange
      when(
        () => mockGetTagsByIds.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await tagsServiceImpl.getTagsByIds([5]);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });

  group("searchTag -", () {
    test("should return (List<TagEntity>) when success", () async {
      //arrange
      when(
        () => mockSearchTag.call(any()),
      ).thenAnswer((_) async => right([]));

      //act
      final result = await tagsServiceImpl.searchTag("name");
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<List<TagEntity>>());
    });

    test("should return kind of (Failure) when fails", () async {
      //arrange
      when(
        () => mockSearchTag.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await tagsServiceImpl.searchTag("name");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });
}
