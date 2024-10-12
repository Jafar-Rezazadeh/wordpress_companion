import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/validator.dart';

void main() {
  test("should return error (String) when value is null", () {
    //arrange
    const value = null;

    //act
    final result = InputValidator.isNotEmpty(value);

    //assert
    expect(result, isA<String>());
  });

  test("should return error (String) when value is empty", () {
    //arrange
    const value = "";

    //act
    final result = InputValidator.isNotEmpty(value);

    //assert
    expect(result, isA<String>());
  });

  test("should return (null) when string is not Null or empty", () {
    //arrange
    const value = "test";

    //act
    final result = InputValidator.isNotEmpty(value);

    //assert
    expect(result, null);
  });
}
