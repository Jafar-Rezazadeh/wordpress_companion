import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

class FakePostEntity extends Fake implements PostEntity {}

class FakePostParams extends Fake implements PostParams {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockPostsRepository mockPostsRepository;
  late UpdatePost updatePost;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    updatePost = UpdatePost(postsRepository: mockPostsRepository);
  });

  setUpAll(() {
    registerFallbackValue(FakePostParams());
  });

  test("should return update post as (PostEntity) when success", () async {
    //arrange
    when(
      () => mockPostsRepository.updatePost(any()),
    ).thenAnswer((_) async => right(FakePostEntity()));

    //act
    final result = await updatePost(FakePostParams());
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<PostEntity>());
  });

  test("should return kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockPostsRepository.updatePost(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await updatePost(FakePostParams());
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
