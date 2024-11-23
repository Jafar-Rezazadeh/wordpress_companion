import 'package:wordpress_companion/features/categories/categories_exports.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryModel> createCategory(CreateOrUpdateCategoryParams params);
  Future<bool> deleteCategory(int id);
  Future<List<CategoryModel>> getAllCategories(GetAllCategoriesParams params);
  Future<CategoryModel> updateCategory(CreateOrUpdateCategoryParams params);
}
