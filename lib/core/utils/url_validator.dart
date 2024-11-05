import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UrlValidator {
  late Dio dio;

  UrlValidator.test({required Dio mockDio}) {
    dio = mockDio;
  }

  UrlValidator() {
    dio = Dio();
  }

  Future<bool> isValidVideoUrl(String url) async {
    try {
      final response = await Dio().head(url);

      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'];

        return contentType != null && contentType.contains("video");
      }
    } catch (e) {
      debugPrint("Error checking URL: $e");
    }
    return false;
  }
}
