import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockCategoriesRemoteDataSource extends Mock
    implements CategoriesRemoteDataSource {}

class FakeCreateOrUpdateCategoryParams extends Fake
    implements CreateOrUpdateCategoryParams {}

class FakeCategoryModel extends Fake implements CategoryModel {}

void main() {
  late MockCategoriesRemoteDataSource mockDataSource;
  late CategoriesRepositoryImpl categoriesRepositoryImpl;
  final fakeCreateEditParams = FakeCreateOrUpdateCategoryParams();

  setUpAll(() {
    registerFallbackValue(FakeCreateOrUpdateCategoryParams());
    registerFallbackValue(GetAllCategoriesParams());
  });

  setUp(() {
    mockDataSource = MockCategoriesRemoteDataSource();
    categoriesRepositoryImpl =
        CategoriesRepositoryImpl(categoriesRemoteDataSource: mockDataSource);
  });

  group("createCategory -", () {
    test("should return (CategoryEntity) when success to create", () async {
      //arrange
      when(
        () => mockDataSource.createCategory(any()),
      ).thenAnswer((_) async => FakeCategoryModel());

      //act
      final result = await categoriesRepositoryImpl.createCategory(
        fakeCreateEditParams,
      );
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<CategoryEntity>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockDataSource.createCategory(any()),
      ).thenAnswer(
          (_) async => throw DioException(requestOptions: RequestOptions()));

      //act
      final result = await categoriesRepositoryImpl.createCategory(
        fakeCreateEditParams,
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when other things thrown", () async {
      //arrange
      when(
        () => mockDataSource.createCategory(any()),
      ).thenThrow(TypeError());

      //act
      final result =
          await categoriesRepositoryImpl.createCategory(fakeCreateEditParams);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("deleteCategory -", () {
    test("should return (bool) when success", () async {
      //arrange
      when(
        () => mockDataSource.deleteCategory(any()),
      ).thenAnswer((_) async => true);

      //act
      final result = await categoriesRepositoryImpl.deleteCategory(1);
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<bool>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockDataSource.deleteCategory(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await categoriesRepositoryImpl.deleteCategory(1);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when other things thrown", () async {
      //arrange
      when(
        () => mockDataSource.deleteCategory(any()),
      ).thenThrow(TypeError());

      //act
      final result = await categoriesRepositoryImpl.deleteCategory(1);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("getAllCategories -", () {
    test("should return (List<CategoryEntity>) when success", () async {
      //arrange
      when(
        () => mockDataSource.getAllCategories(any()),
      ).thenAnswer((invocation) async => []);

      //act
      final result = await categoriesRepositoryImpl.getAllCategories(
        GetAllCategoriesParams(),
      );
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<List<CategoryEntity>>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockDataSource.getAllCategories(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await categoriesRepositoryImpl
          .getAllCategories(GetAllCategoriesParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when other things thrown", () async {
      //arrange
      when(
        () => mockDataSource.getAllCategories(any()),
      ).thenThrow(TypeError());

      //act
      final result = await categoriesRepositoryImpl
          .getAllCategories(GetAllCategoriesParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("updateCategory -", () {
    test("should return (CategoryEntity) when success", () async {
      //arrange
      when(
        () => mockDataSource.updateCategory(any()),
      ).thenAnswer((_) async => FakeCategoryModel());

      //act
      final result =
          await categoriesRepositoryImpl.updateCategory(fakeCreateEditParams);
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<CategoryEntity>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockDataSource.updateCategory(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result =
          await categoriesRepositoryImpl.updateCategory(fakeCreateEditParams);

      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when other things thrown", () async {
      //arrange
      when(
        () => mockDataSource.updateCategory(any()),
      ).thenThrow(TypeError());

      //act
      final result =
          await categoriesRepositoryImpl.updateCategory(fakeCreateEditParams);

      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });
}
