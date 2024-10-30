import 'package:dio/dio.dart';

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
        // Check if the URL points to a video file by examining the Content-Type header
        // print(response.headers);
        final contentType = response.headers['content-type'];
        print("contentType: $contentType");
        return contentType != null && contentType.contains("video");
      }
    } catch (e) {
      print("Error checking URL: $e");
    }
    return false; // URL is not valid or doesn't point to a video
  }
}
