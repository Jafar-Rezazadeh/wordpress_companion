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
}
