import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class GetAllCategories
    implements UseCase<List<CategoryEntity>, GetAllCategoriesParams> {
  final CategoriesRepository _categoryRepository;

  GetAllCategories({
    required CategoriesRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;
  @override
  Future<Either<Failure, List<CategoryEntity>>> call(params) {
    return _categoryRepository.getAllCategories(params);
  }
}

class GetAllCategoriesParams {
  final CategoryOrderByEnum? orderby;
  final String? search;

  GetAllCategoriesParams({
    this.orderby,
    this.search,
  });
}
