import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

class FakePostsPageResult extends Fake implements PostsPageResult {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockPostsRepository mockPostsRepository;
  late GetPostsPerPage getPostsPerPage;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    getPostsPerPage = GetPostsPerPage(postsRepository: mockPostsRepository);
  });

  setUpAll(() {
    registerFallbackValue(GetPostsPerPageParams());
  });

  group("getPostsPerPageParams -", () {
    group("on create -", () {
      test("should throw AssertionError when page is less than 1 ", () {
        //assert
        expect(() => GetPostsPerPageParams(page: 0), throwsAssertionError);
      });
      test("should throw AssertionError when perPage is less than 10 ", () {
        //assert
        expect(() => GetPostsPerPageParams(perPage: 9), throwsAssertionError);
      });
    });
    group("copyWith -", () {
      test("should return (GetPostsPerPageParams)", () {
        //arrange
        final params = GetPostsPerPageParams();

        //act
        final result = params.copyWith();

        //assert
        expect(result, isA<GetPostsPerPageParams>());
      });
      test(
          "should set the given properties return the expected (GetPostsPerPageParams) contain the give n props",
          () {
        //arrange
        final params = GetPostsPerPageParams();

        //act
        final result = params.copyWith(
          page: 2,
          perPage: 20,
          search: "test",
          after: "test",
          before: "test",
          status: [PostStatusEnum.pending],
          categories: [1, 2, 3],
        );

        //assert
        expect(result, isA<GetPostsPerPageParams>());
        expect(result.page, 2);
        expect(result.perPage, 20);
        expect(result.search, "test");
        expect(result.after, "test");
        expect(result.before, "test");
        expect(result.status, [PostStatusEnum.pending]);
        expect(result.categories, [1, 2, 3]);
      });

      test("should return the same when no params given ", () {
        //arrange
        final params = GetPostsPerPageParams();

        //act
        final result = params.copyWith();

        //assert
        expect(result.page, params.page);
        expect(result.perPage, params.perPage);
        expect(result.search, params.search);
        expect(result.after, params.after);
        expect(result.before, params.before);
        expect(result.categories, params.categories);
        expect(result.status, params.status);
      });

      test("should throw assertion error when page is less than 1", () {
        //arrange
        final params = GetPostsPerPageParams();

        //assert
        expect(() => params.copyWith(page: 0), throwsAssertionError);
      });

      test("should throw assertion error when perPage is less than 10", () {
        //arrange
        final params = GetPostsPerPageParams();

        //assert
        expect(() => params.copyWith(perPage: 9), throwsAssertionError);
      });
    });
  });

  group("useCase -", () {
    test("should return (PostsPageResult) when success", () async {
      //arrange
      when(
        () => mockPostsRepository.getPostsPerPage(any()),
      ).thenAnswer((_) async => right(FakePostsPageResult()));

      //act
      final result = await getPostsPerPage(GetPostsPerPageParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<PostsPageResult>());
    });

    test("should return kind of (Failure) when fails", () async {
      //arrange
      when(
        () => mockPostsRepository.getPostsPerPage(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await getPostsPerPage(GetPostsPerPageParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });
}
