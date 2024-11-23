import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class MockTagsRemoteDataSource extends Mock implements TagsRemoteDataSource {}

class FakeTagModel extends Fake implements TagModel {}

void main() {
  late MockTagsRemoteDataSource mockTagsRemoteDataSource;
  late TagsRepositoryImpl tagsRepositoryImpl;

  setUp(() {
    mockTagsRemoteDataSource = MockTagsRemoteDataSource();
    tagsRepositoryImpl = TagsRepositoryImpl(
      tagsRemoteDataSource: mockTagsRemoteDataSource,
    );
  });

  group("createTag -", () {
    test("should return (TagEntity) when success", () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.createTag(any()),
      ).thenAnswer((_) async => FakeTagModel());

      //act
      final result = await tagsRepositoryImpl.createTag("name");
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<TagEntity>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.createTag(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await tagsRepositoryImpl.createTag("name");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when any unknown object is thrown",
        () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.createTag(any()),
      ).thenThrow(TypeError());

      //act
      final result = await tagsRepositoryImpl.createTag("name");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("getTagsByIds -", () {
    test("should return (List<TagEntity>) when success", () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.getTagsByIds(any()),
      ).thenAnswer((_) async => []);

      //act
      final result = await tagsRepositoryImpl.getTagsByIds([5]);
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<List<TagEntity>>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.getTagsByIds(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await tagsRepositoryImpl.getTagsByIds([5]);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when unknown object is thrown",
        () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.getTagsByIds(any()),
      ).thenThrow(TypeError());

      //act
      final result = await tagsRepositoryImpl.getTagsByIds([5]);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("searchTag -", () {
    test("should return (List<TagEntity>) when success", () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.searchTag(any()),
      ).thenAnswer((_) async => []);

      //act
      final result = await tagsRepositoryImpl.searchTag("name");
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<List<TagEntity>>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.searchTag(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await tagsRepositoryImpl.searchTag("name");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when unknown object is thrown",
        () async {
      //arrange
      when(
        () => mockTagsRemoteDataSource.searchTag(any()),
      ).thenThrow(TypeError());

      //act
      final result = await tagsRepositoryImpl.searchTag("name");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });
}
