import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';

void main() {
  group("convertToJson -", () {
    test("should return (Map<String,dynamic>) when response data is jsonString",
        () {
      //arrange
      final jsonString = jsonEncode({"id": 1, "name": "someName"});

      //act
      final result = ApiResponseHandler.convertToJson(jsonString);

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });
    test(
        "should return (Map<String, dynamic>) if the given data is already a map",
        () {
      //arrange
      final json = {"id": 1, "name": "someName"};

      //act
      final result = ApiResponseHandler.convertToJson(json);

      //assert
      expect(result, isA<Map<String, dynamic>>());
    });
  });

  group("convertToJsonList -", () {
    test("should return same when input is List<dynamic>", () {
      //arrange
      final json = [
        {"id": 1, "name": "someName"},
        {"id": 2, "name": "someName"}
      ];

      //act
      final result = ApiResponseHandler.convertToJsonList(json);

      //assert
      expect(result, isA<List<dynamic>>());
    });

    test("should return (List<dynamic>) when input is jsonString", () {
      //arrange
      final jsonString = jsonEncode([
        {"id": 1, "name": "someName"},
        {"id": 2, "name": "someName"}
      ]);

      //act
      final result = ApiResponseHandler.convertToJsonList(jsonString);

      //assert
      expect(result, isA<dynamic>());
      expect(result[0]["id"], 1);
    });
  });
}
