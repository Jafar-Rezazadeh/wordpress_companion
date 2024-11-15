import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

void main() {
  late MockCategoriesRepository mockCategoriesRepository;
  late GetAllCategories getAllCategories;
  final params = GetAllCategoriesParams();

  setUpAll(() {
    registerFallbackValue(params);
  });

  setUp(() {
    mockCategoriesRepository = MockCategoriesRepository();
    getAllCategories =
        GetAllCategories(categoryRepository: mockCategoriesRepository);
  });

  test("should return (List<CategoryEntity>) when success", () async {
    //arrange
    when(
      () => mockCategoriesRepository.getAllCategories(any()),
    ).thenAnswer((_) async => right([]));

    //act
    final result = await getAllCategories(params);
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<List<CategoryEntity>>());
  });

  test("should return kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockCategoriesRepository.getAllCategories(any()),
    ).thenAnswer(
      (_) async => left(
        InternalFailure(
            message: "message",
            stackTrace: StackTrace.fromString("stackTraceString")),
      ),
    );

    //act
    final result = await getAllCategories(params);
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
