import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockCategoriesRepository mockCategoriesRepository;
  late DeleteCategory deleteCategory;

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
    deleteCategory = DeleteCategory(
      categoriesRepository: mockCategoriesRepository,
    );
  });

  test("should return (bool) when delete request is success", () async {
    //arrange
    when(
      () => mockCategoriesRepository.deleteCategory(any()),
    ).thenAnswer((_) async => right(true));

    //act
    final result = await deleteCategory(1);
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<bool>());
  });

  test("should return kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockCategoriesRepository.deleteCategory(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await deleteCategory(1);
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
