import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/core_export.dart';

import '../../categories_exports.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories(
    GetAllCategoriesParams params,
  );
  Future<Either<Failure, CategoryEntity>> createCategory(
    CreateOrUpdateCategoryParams params,
  );
  Future<Either<Failure, CategoryEntity>> updateCategory(
    CreateOrUpdateCategoryParams params,
  );
  Future<Either<Failure, bool>> deleteCategory(int params);
}
