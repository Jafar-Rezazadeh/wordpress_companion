import 'dart:async';

import 'package:dio/dio.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MediaRemoteDataSourceImpl implements MediaRemoteDataSource {
  final Dio _dio;

  MediaRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<bool> deleteMedia(int id) async {
    final response = await _dio.delete(
      "$wpV2EndPoint/media/$id",
      queryParameters: {
        "force": "true",
      },
    );

    final json = ApiResponseHandler.convertToJson(response.data);

    return json["deleted"];
  }

  @override
  Future<CurrentPageMediasEntity> getMediasPerPage(
    GetMediaPerPageParams params,
  ) async {
    final response = await _dio.get(
      "$wpV2EndPoint/media",
      queryParameters: {
        "page": params.page,
        "per_page": params.perPage,
        "_embed": "author",
        if (params.search != null) "search": params.search,
        if (params.after != null) "after": params.after,
        if (params.before != null) "before": params.before,
        if (params.type != null) "media_type": params.type!.name,
      },
    );

    final listOfMedias = ApiResponseHandler.convertToJsonList(response.data);

    final hasMore = listOfMedias.length >= params.perPage;

    return CurrentPageMediasEntity(
      hasMoreMedias: hasMore,
      medias: listOfMedias.map((e) => MediaModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<MediaModel> updateMedia(UpdateMediaParams params) async {
    final response = await _dio.put(
      "$wpV2EndPoint/media/${params.id}",
      data: MediaModel.fromParamsToJson(params),
    );
    final json = ApiResponseHandler.convertToJson(response.data);

    return MediaModel.fromJson(json);
  }

  @override
  UploadMediaResult uploadMediaFile(String pathToFile) {
    final fileData = FormData.fromMap(
      {
        'file': MultipartFile.fromFileSync(pathToFile),
      },
    );

    final controller = StreamController<double>();
    final cancelToken = CancelToken();

    _dio.post(
      "$wpV2EndPoint/media",
      data: fileData,
      cancelToken: cancelToken,
      options: Options(
        headers: {
          "content-type": "multipart/form-data",
        },
      ),
      onSendProgress: (count, total) {
        controller.add(count / total);
      },
    ).then((response) {
      controller.close();
    }).onError((error, stackTrace) {
      controller.addError(error ?? "خطا در بارگذاری فایل");
      controller.close();
    }).catchError((error) {
      controller.close();
    });

    return (
      stream: controller.stream,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<void> cancelMediaUpload(CancelToken cancelToken) async {
    cancelToken.cancel("بارگذاری فایل توسط کاربر لغو شد.");
  }
}
