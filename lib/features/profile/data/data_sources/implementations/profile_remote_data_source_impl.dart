import 'package:dio/dio.dart';
import '../../../../../core/core_export.dart';
import '../../../profile_exports.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<ProfileModel> getMyProfile() async {
    final response = await _dio.get("$wpV2EndPoint/users/me");

    final json = ApiResponseHandler.convertToJson(response.data);

    return ProfileModel.fromJson(json);
  }

  @override
  Future<ProfileModel> updateMyProfile(UpdateMyProfileParams params) async {
    final response = await _dio.put(
      "$wpV2EndPoint/users/me",
      data: ProfileModel.toJsonFromParams(params),
    );

    final json = ApiResponseHandler.convertToJson(response.data);

    return ProfileModel.fromJson(json);
  }
}
