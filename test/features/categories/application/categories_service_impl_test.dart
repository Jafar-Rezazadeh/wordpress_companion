import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/categories/application/categories_service_impl.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockGetAllCategories extends Mock implements GetAllCategories {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockGetAllCategories mockGetAllCategories;
  late CategoriesServiceImpl categoriesServiceImpl;

  setUpAll(() {
    registerFallbackValue(GetAllCategoriesParams());
  });

  setUp(() {
    mockGetAllCategories = MockGetAllCategories();
    categoriesServiceImpl = CategoriesServiceImpl(
      getAllCategories: mockGetAllCategories,
    );
  });

  test("should return (List<CategoryEntity>) when success", () async {
    //arrange
    when(
      () => mockGetAllCategories.call(any()),
    ).thenAnswer((_) async => right([]));

    //act
    final result = await categoriesServiceImpl.getAllCategories();
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<List<CategoryEntity>>());
  });

  test("should kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockGetAllCategories.call(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await categoriesServiceImpl.getAllCategories();
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
