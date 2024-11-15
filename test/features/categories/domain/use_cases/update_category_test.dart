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
  late UpdateCategory updateCategory;
  final fakeParams = FakeCreateOrUpdateCategoryParams();

  setUpAll(() {
    registerFallbackValue(fakeParams);
  });

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
    updateCategory = UpdateCategory(
      categoryRepository: mockCategoriesRepository,
    );
  });

  test("should return updated category as (CategoryEntity) when success",
      () async {
    //arrange
    when(
      () => mockCategoriesRepository.updateCategory(any()),
    ).thenAnswer((_) async => right(FakeCategoryEntity()));

    //act
    final result = await updateCategory(fakeParams);
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<CategoryEntity>());
  });

  test("should return kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockCategoriesRepository.updateCategory(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await updateCategory(fakeParams);
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
