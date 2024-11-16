import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final Dio _dio;

  CategoriesRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<CategoryModel> createCategory(
      CreateOrUpdateCategoryParams params) async {
    final response = await _dio.post(
      "$wpV2EndPoint/categories",
      data: CategoryModel.fromParamsToJson(params),
    );

    final jsonData = ApiResponseHandler.convertToJson(response.data);

    return CategoryModel.fromJson(jsonData);
  }

  @override
  Future<bool> deleteCategory(int id) async {
    final response = await _dio.delete(
      "$wpV2EndPoint/categories/$id",
      queryParameters: {
        "force": true,
      },
    );

    final jsonData = ApiResponseHandler.convertToJson(response.data);

    return jsonData["deleted"];
  }

  @override
  Future<List<CategoryModel>> getAllCategories(
      GetAllCategoriesParams params) async {
    int currentPage = 1;
    List<dynamic> allCategories = [];

    while (true) {
      final response = await _dio.get(
        "$wpV2EndPoint/categories",
        queryParameters: {
          "page": currentPage,
          "per_page": 100,
          if (params.search != null) "search": params.search,
          if (params.orderby != null) "orderby": params.orderby?.name,
        },
      );

      final jsonData = ApiResponseHandler.convertToJsonList(response.data);

      allCategories.addAll(jsonData);

      final hasNextPage = _hasNextPage(response.headers, currentPage);

      if (hasNextPage) {
        currentPage++;
      } else {
        break;
      }
    }

    return allCategories.map((e) => CategoryModel.fromJson(e)).toList();
  }

  bool _hasNextPage(Headers headers, int currentPage) {
    final totalPages =
        int.tryParse(headers["x-wp-totalpages"]?.first ?? "1") ?? 1;
    return currentPage < totalPages;
  }

  @override
  Future<CategoryModel> updateCategory(
      CreateOrUpdateCategoryParams params) async {
    final response = await _dio.put(
      "$wpV2EndPoint/categories/${params.id}",
      data: CategoryModel.fromParamsToJson(params),
    );

    final jsonData = ApiResponseHandler.convertToJson(response.data);

    return CategoryModel.fromJson(jsonData);
  }
}
