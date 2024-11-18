import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockGetAllCategories extends Mock implements GetAllCategories {}

class MockCreateCategory extends Mock implements CreateCategory {}

class MockUpdateCategory extends Mock implements UpdateCategory {}

class MockDeleteCategory extends Mock implements DeleteCategory {}

class FakeFailure extends Fake implements Failure {}

class FakeCreateOrUpdateCategoryParams extends Fake
    implements CreateOrUpdateCategoryParams {}

class FakeCategoryEntity extends Fake implements CategoryEntity {}

void main() {
  late MockGetAllCategories mockGetAllCategories;
  late MockCreateCategory mockCreateCategory;
  late MockUpdateCategory mockUpdateCategory;
  late MockDeleteCategory mockDeleteCategory;
  late CategoriesCubit categoriesCubit;
  final createOrUpdateParams = FakeCreateOrUpdateCategoryParams();

  setUpAll(() {
    registerFallbackValue(GetAllCategoriesParams());
    registerFallbackValue(createOrUpdateParams);
  });

  setUp(
    () {
      mockGetAllCategories = MockGetAllCategories();
      mockCreateCategory = MockCreateCategory();
      mockUpdateCategory = MockUpdateCategory();
      mockDeleteCategory = MockDeleteCategory();
      categoriesCubit = CategoriesCubit(
        getAllCategories: mockGetAllCategories,
        createCategory: mockCreateCategory,
        updateCategory: mockUpdateCategory,
        deleteCategory: mockDeleteCategory,
      );
    },
  );

  group("getAllCategories -", () {
    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, loaded] when success',
      setUp: () {
        when(
          () => mockGetAllCategories.call(any()),
        ).thenAnswer((_) async => right([]));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.getAllCategories(GetAllCategoriesParams()),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loaded: (_) => true),
          "is loaded state",
          true,
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockGetAllCategories.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.getAllCategories(GetAllCategoriesParams()),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });

  group("createCategory -", () {
    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, needRefresh] when success',
      setUp: () {
        when(
          () => mockCreateCategory.call(any()),
        ).thenAnswer((_) async => right(FakeCategoryEntity()));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.createCategory(createOrUpdateParams),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(needRefresh: () => true),
          "is needRefresh state",
          true,
        ),
      ],
    );
    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockCreateCategory.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.createCategory(createOrUpdateParams),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });

  group("updateCategory -", () {
    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, needRefresh] when success',
      setUp: () {
        when(
          () => mockUpdateCategory.call(any()),
        ).thenAnswer((_) async => right(FakeCategoryEntity()));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.updateCategory(createOrUpdateParams),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(needRefresh: () => true),
          "is needRefresh state",
          true,
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockUpdateCategory.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.updateCategory(createOrUpdateParams),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });

  group("deleteCategory -", () {
    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, needRefresh] when success',
      setUp: () {
        when(
          () => mockDeleteCategory.call(any()),
        ).thenAnswer((_) async => right(true));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.deleteCategory(1),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(needRefresh: () => true),
          "is needRefresh state",
          true,
        ),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'emits [loading, error] when fails',
      setUp: () {
        when(
          () => mockDeleteCategory.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => categoriesCubit,
      act: (cubit) => cubit.deleteCategory(1),
      expect: () => [
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(loading: () => true),
          "is loading state",
          true,
        ),
        isA<CategoriesState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          "is error state",
          true,
        ),
      ],
    );
  });
}
