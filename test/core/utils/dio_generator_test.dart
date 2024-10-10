import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/dio_generator.dart';

void main() {
  test("should has the (context=edit) query parameter ", () {
    //arrange
    final dio = DioGenerator.generateDioWithDefaultSettings();

    //act
    final queryParams = dio.options.queryParameters;

    //assert
    expect(queryParams.containsKey("context"), true);
    expect(queryParams["context"], "edit");
  });
}
