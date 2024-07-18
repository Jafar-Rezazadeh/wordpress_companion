import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/home/domain/entities/post_entity.dart';

import 'package:wordpress_companion/features/home/home_exports.dart';

class MockPostService extends Mock implements PostService {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockPostService mockPostService;
  late GetLatestPosts getLatestPosts;
  const GetLatestPostsParams params = GetLatestPostsParams();

  setUp(() {
    mockPostService = MockPostService();
    getLatestPosts = GetLatestPosts(postService: mockPostService);
  });

  test(
    "should return (List of posts) when success",
    () async {
      //arrange
      when(
        () => mockPostService.getLatestPosts(params),
      ).thenAnswer((invocation) async => right([]));

      //act
      final result = await getLatestPosts.call(params);
      final posts = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(posts, isA<List<PostEntity>>());
    },
  );

  test(
    "should return (Failure) when unsuccessful",
    () async {
      //arrange
      when(
        () => mockPostService.getLatestPosts(params),
      ).thenAnswer((invocation) async => left(FakeFailure()));

      //act
      final result = await getLatestPosts.call(params);
      final failure = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(failure, isA<Failure>());
    },
  );
}
