import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class DeleteCategory implements UseCase<bool, int> {
  final CategoriesRepository _categoriesRepository;

  DeleteCategory({
    required CategoriesRepository categoriesRepository,
  }) : _categoriesRepository = categoriesRepository;
  @override
  Future<Either<Failure, bool>> call(int params) {
    return _categoriesRepository.deleteCategory(params);
  }
}
