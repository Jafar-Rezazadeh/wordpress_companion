import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/core/services/categories_service.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CategoriesServiceImpl implements CategoriesService {
  final GetAllCategories _getAllCategories;

  CategoriesServiceImpl({
    required GetAllCategories getAllCategories,
  }) : _getAllCategories = getAllCategories;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    return _getAllCategories.call(GetAllCategoriesParams());
  }
}
