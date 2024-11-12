import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

class FakePostModel extends Fake implements PostModel {}

class FakePostParams extends Fake implements PostParams {}

class FakePostsPageResult extends Fake implements PostsPageResult {}

void main() {
  late MockPostsRemoteDataSource mockPostsRemoteDataSource;
  late PostsRepositoryImpl postsRepositoryImpl;

  setUpAll(() {
    registerFallbackValue(FakePostParams());
    registerFallbackValue(GetPostsPerPageParams());
  });

  setUp(() {
    mockPostsRemoteDataSource = MockPostsRemoteDataSource();
    postsRepositoryImpl =
        PostsRepositoryImpl(postsRemoteDataSource: mockPostsRemoteDataSource);
  });

  group("createPost -", () {
    test("should return create post as (PostEntity) when success", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.createPost(any()),
      ).thenAnswer((_) async => FakePostModel());

      //act
      final result = await postsRepositoryImpl.createPost(FakePostParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<PostEntity>());
    });

    test("should return (ServerFailure) when DioException thrown", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.createPost(any()),
      ).thenAnswer(
        (_) async => throw DioException(requestOptions: RequestOptions()),
      );

      //act
      final result = await postsRepositoryImpl.createPost(FakePostParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when any other exception is thrown",
        () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.createPost(any()),
      ).thenAnswer((_) async => throw Exception());

      //act
      final result = await postsRepositoryImpl.createPost(FakePostParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("deletePost -", () {
    test("should return deleted post as (PostEntity) when success", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.deletePost(any()),
      ).thenAnswer((_) async => FakePostModel());

      //act
      final result = await postsRepositoryImpl.deletePost(1);
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<PostEntity>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.deletePost(any()),
      ).thenAnswer(
        (_) async => throw DioException(requestOptions: RequestOptions()),
      );

      //act
      final result = await postsRepositoryImpl.deletePost(1);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when any other exception is thrown",
        () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.deletePost(any()),
      ).thenAnswer((_) async => throw Exception());

      //act
      final result = await postsRepositoryImpl.deletePost(1);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("getPostsPerPage -", () {
    test("should return (PostsPageResult) when success", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.getPostsPerPage(any()),
      ).thenAnswer((_) async => FakePostsPageResult());

      //act
      final result = await postsRepositoryImpl.getPostsPerPage(
        GetPostsPerPageParams(),
      );
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<PostsPageResult>());
    });
    test("should return (ServerFailure) when dioException is thrown", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.getPostsPerPage(any()),
      ).thenAnswer(
        (_) async => throw DioException(requestOptions: RequestOptions()),
      );

      //act
      final result = await postsRepositoryImpl.getPostsPerPage(
        GetPostsPerPageParams(),
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });
    test("should return (InternalFailure) when any other exception is thrown",
        () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.getPostsPerPage(any()),
      ).thenAnswer((_) async => throw TypeError());

      //act
      final result = await postsRepositoryImpl.getPostsPerPage(
        GetPostsPerPageParams(),
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("updatePost -", () {
    test("should return updated post as (PostEntity) when success", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.updatePost(any()),
      ).thenAnswer((_) async => FakePostModel());

      //act
      final result = await postsRepositoryImpl.updatePost(FakePostParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<PostEntity>());
    });
    test("should return (ServerFailure) when DioException thrown", () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.updatePost(any()),
      ).thenAnswer(
        (_) async => throw DioException(requestOptions: RequestOptions()),
      );

      //act
      final result = await postsRepositoryImpl.updatePost(FakePostParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });
    test("should return (InternalFailure) when any other thing thrown",
        () async {
      //arrange
      when(
        () => mockPostsRemoteDataSource.updatePost(any()),
      ).thenAnswer(
        (_) async => throw TypeError(),
      );

      //act
      final result = await postsRepositoryImpl.updatePost(FakePostParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });
}
