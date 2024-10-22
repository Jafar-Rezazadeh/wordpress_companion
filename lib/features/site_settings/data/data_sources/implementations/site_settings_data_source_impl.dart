import 'package:dio/dio.dart';
import '../../../site_settings_exports.dart';

import '../../../../../core/core_export.dart';

class SiteSettingsDataSourceImpl implements SiteSettingsDataSource {
  final Dio _dio;

  SiteSettingsDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<SiteSettingsModel> getSettings() async {
    final response = await _dio.get("$wpV2EndPoint/settings");

    final json = ApiResponseHandler.convertToJson(response.data);

    return SiteSettingsModel.fromJson(json);
  }

  @override
  Future<SiteSettingsModel> updateSettings(
      UpdateSiteSettingsParams params) async {
    final response = await _dio.put(
      "$wpV2EndPoint/settings",
      data: SiteSettingsModel.fromParamsToJson(params),
    );

    final json = ApiResponseHandler.convertToJson(response.data);

    return SiteSettingsModel.fromJson(json);
  }
}
