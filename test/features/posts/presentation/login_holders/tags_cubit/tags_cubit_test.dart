import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/tags_service.dart';
import 'package:wordpress_companion/features/posts/presentation/login_holders/tags_cubit/tags_cubit.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class MockTagsService extends Mock implements TagsService {}

class FakeTagEntity extends Fake implements TagEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockTagsService mockTagsService;
  late TagsCubit tagsCubit;

  setUp(() {
    mockTagsService = MockTagsService();
    tagsCubit = TagsCubit(tagsService: mockTagsService);
  });

  group("createTag", () {
    blocTest<TagsCubit, TagsState>(
      'emits [loading , created] when success',
      setUp: () {
        when(
          () => mockTagsService.createTag(any()),
        ).thenAnswer((_) async => right(FakeTagEntity()));
      },
      build: () => tagsCubit,
      act: (cubit) => cubit.createTag("test"),
      expect: () => [
        isA<TagsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<TagsState>().having(
          (state) => state.whenOrNull(created: (_) => true),
          "is created state",
          true,
        ),
      ],
    );

    blocTest<TagsCubit, TagsState>(
      'emits [loading , error] when fails',
      setUp: () {
        when(
          () => mockTagsService.createTag(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => tagsCubit,
      act: (cubit) => cubit.createTag("test"),
      expect: () => [
        isA<TagsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<TagsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });

  group("getTagsByIds -", () {
    blocTest<TagsCubit, TagsState>(
      'emits [loading , tagsByIds] when success',
      setUp: () {
        when(
          () => mockTagsService.getTagsByIds(any()),
        ).thenAnswer((_) async => right([]));
      },
      build: () => tagsCubit,
      act: (cubit) => cubit.getTagsByIds([5]),
      expect: () => [
        isA<TagsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<TagsState>().having(
          (state) => state.whenOrNull(tagsByIds: (_) => true),
          "is tagsByIds state",
          true,
        ),
      ],
    );

    blocTest<TagsCubit, TagsState>(
      'emits [loading , error] when fails',
      setUp: () {
        when(
          () => mockTagsService.getTagsByIds(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => tagsCubit,
      act: (cubit) => cubit.getTagsByIds([5]),
      expect: () => [
        isA<TagsState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<TagsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });

  group("searchTag -", () {
    //
    blocTest<TagsCubit, TagsState>(
      'emits [] when current state is searching',
      seed: () => const TagsState.searching(),
      setUp: () {},
      build: () => tagsCubit,
      act: (cubit) => cubit.searchTag("value"),
      expect: () => [],
      verify: (bloc) => verifyNever(() => mockTagsService.searchTag(any())),
    );

    blocTest<TagsCubit, TagsState>(
      'emits [searching, searchResult] when success',
      setUp: () {
        when(
          () => mockTagsService.searchTag(any()),
        ).thenAnswer((_) async => right([]));
      },
      build: () => tagsCubit,
      act: (cubit) => cubit.searchTag("string"),
      expect: () => [
        isA<TagsState>().having(
          (state) => state.whenOrNull(searching: () => true),
          "is searching state",
          true,
        ),
        isA<TagsState>().having(
          (state) => state.whenOrNull(searchResult: (_) => true),
          "is searchResult state",
          true,
        ),
      ],
    );
    blocTest<TagsCubit, TagsState>(
      'emits [searching, error] when fails',
      setUp: () {
        when(
          () => mockTagsService.searchTag(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => tagsCubit,
      act: (cubit) => cubit.searchTag("string"),
      expect: () => [
        isA<TagsState>().having(
          (state) => state.whenOrNull(searching: () => true),
          "is searching state",
          true,
        ),
        isA<TagsState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });
}
