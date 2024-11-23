import 'package:dartz/dartz.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class GetAllCategories
    implements UseCase<List<CategoryEntity>, GetAllCategoriesParams> {
  final CategoriesRepository _categoryRepository;

  GetAllCategories({
    required CategoriesRepository categoriesRepository,
  }) : _categoryRepository = categoriesRepository;
  @override
  Future<Either<Failure, List<CategoryEntity>>> call(params) {
    return _categoryRepository.getAllCategories(params);
  }
}

class GetAllCategoriesParams {
  CategoryOrderByEnum? _orderby;
  String? _search;

  setSearch(String? value) {
    _search = value;
    return this;
  }

  setOrderBy(CategoryOrderByEnum? orderby) {
    _orderby = orderby;
    return this;
  }

  CategoryOrderByEnum? get orderby => _orderby;

  String? get search => _search;
}
