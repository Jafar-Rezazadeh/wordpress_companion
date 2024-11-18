import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

class FakeCreateOrUpdateCategoryParams extends Fake
    implements CreateOrUpdateCategoryParams {}

class FakeCategoryEntity extends Fake implements CategoryEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockCategoriesRepository mockCategoriesRepository;
  late CreateCategory createCategory;

  setUpAll(() {
    registerFallbackValue(FakeCreateOrUpdateCategoryParams());
  });

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
    createCategory =
        CreateCategory(categoriesRepository: mockCategoriesRepository);
  });

  test("should return create category as (CategoryEntity) when success",
      () async {
    //arrange
    when(
      () => mockCategoriesRepository.createCategory(any()),
    ).thenAnswer((_) async => right(FakeCategoryEntity()));

    //act
    final result = await createCategory(FakeCreateOrUpdateCategoryParams());
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<CategoryEntity>());
  });

  test("should return kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockCategoriesRepository.createCategory(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await createCategory(FakeCreateOrUpdateCategoryParams());
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
