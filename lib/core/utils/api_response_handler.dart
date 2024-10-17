import 'dart:convert';

class ApiResponseHandler {
  static convertToJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    }

    return jsonDecode(json);
  }
}
