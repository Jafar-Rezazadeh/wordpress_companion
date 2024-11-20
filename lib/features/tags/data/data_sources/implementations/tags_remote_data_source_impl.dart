import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class TagsRemoteDataSourceImpl implements TagsRemoteDataSource {
  final Dio _dio;

  TagsRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<TagModel> createTag(String name) async {
    final response = await _dio.post("$wpV2EndPoint/tags",
        data: TagModel.fromParamsToJson(name));

    final json = ApiResponseHandler.convertToJson(response.data);

    return TagModel.fromJson(json);
  }

  @override
  Future<List<TagModel>> getTagsByIds(List<int> ids) async {
    final response = await _dio.get(
      "$wpV2EndPoint/tags",
      queryParameters: {
        "include": ids.join(","),
      },
    );

    final jsonList = ApiResponseHandler.convertToJsonList(response.data);

    return jsonList.map((e) => TagModel.fromJson(e)).toList();
  }

  @override
  Future<List<TagModel>> searchTag(String value) async {
    final response = await _dio.get(
      "$wpV2EndPoint/tags",
      queryParameters: {
        "search": value,
      },
    );
    final jsonList = ApiResponseHandler.convertToJsonList(response.data);

    return jsonList.map((e) => TagModel.fromJson(e)).toList();
  }
}
