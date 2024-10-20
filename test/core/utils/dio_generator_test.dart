import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/dio_generator.dart';

void main() {
  test("should contains the (context=edit) query parameter ", () {
    //arrange
    final dio = DioGenerator.generateDioWithDefaultSettings();

    //act
    final queryParams = dio.options.queryParameters;

    //assert
    expect(queryParams.containsKey("context"), true);
    expect(queryParams["context"], "edit");
  });
  test("should contains (content-type) in headers ", () {
    //arrange
    final dio = DioGenerator.generateDioWithDefaultSettings();

    //act
    final headers = dio.options.headers;

    //assert
    expect(headers.keys, contains("content-type"));
    expect(headers["content-type"], "application/json");
  });
}
