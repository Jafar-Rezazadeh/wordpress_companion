import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

abstract class CategoriesService {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
}
