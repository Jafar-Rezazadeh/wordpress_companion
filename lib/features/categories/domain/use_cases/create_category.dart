import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CreateCategory
    implements UseCase<CategoryEntity, CreateOrUpdateCategoryParams> {
  final CategoriesRepository _categoryRepository;

  CreateCategory({
    required CategoriesRepository categoriesRepository,
  }) : _categoryRepository = categoriesRepository;

  @override
  Future<Either<Failure, CategoryEntity>> call(
    CreateOrUpdateCategoryParams params,
  ) {
    return _categoryRepository.createCategory(params);
  }
}