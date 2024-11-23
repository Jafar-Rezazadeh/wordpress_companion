import 'package:dartz/dartz.dart';

import 'package:wordpress_companion/core/errors/failures.dart';

import '../../categories_exports.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;

  CategoriesRepositoryImpl({
    required CategoriesRemoteDataSource categoriesRemoteDataSource,
  }) : _categoriesRemoteDataSource = categoriesRemoteDataSource;

  @override
  Future<Either<Failure, CategoryEntity>> createCategory(
      CreateOrUpdateCategoryParams params) async {
    try {
      final result = await _categoriesRemoteDataSource.createCategory(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(int params) async {
    try {
      final result = await _categoriesRemoteDataSource.deleteCategory(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories(
    GetAllCategoriesParams params,
  ) async {
    try {
      final result = await _categoriesRemoteDataSource.getAllCategories(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> updateCategory(
      CreateOrUpdateCategoryParams params) async {
    try {
      final result = await _categoriesRemoteDataSource.updateCategory(params);

      return right(result);
    } catch (e, s) {
      return left(FailureFactory.createFailure(e, s));
    }
  }
}
