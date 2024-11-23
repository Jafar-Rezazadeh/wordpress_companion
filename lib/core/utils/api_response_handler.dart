import 'dart:convert';

class ApiResponseHandler {
  static Map<String, dynamic> convertToJson(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    return jsonDecode(data);
  }

  static List<dynamic> convertToJsonList(dynamic data) {
    if (data is List<dynamic>) {
      return data;
    }

    return jsonDecode(data);
  }
}
