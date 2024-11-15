import 'package:dio/dio.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final Dio _dio;

  CategoriesRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<CategoryModel> createCategory(CreateOrUpdateCategoryParams params) {
    // TODO: implement createCategory
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCategory(int id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getAllCategories(GetAllCategoriesParams params) {
    // TODO: implement getAllCategories
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> updateCategory(CreateOrUpdateCategoryParams params) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
