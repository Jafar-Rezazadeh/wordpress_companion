import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/string_formatter.dart';

void main() {
  test("should return the text in the given maxLength and add ... at the end ",
      () {
    //arrange
    const String text = "test";

    //act
    final result = StringFormatter.shortenText(text, 2);

    //assert
    expect(result, "te...");
    expect(result.length, 5);
  });

  test(
      "should return the full text if the text length is less than the maxLength",
      () {
    //arrange
    const text = "hello";

    //act
    final result = StringFormatter.shortenText(text, 50);

    //assert
    expect(result, "hello");
    expect(result.length, 5);
  });
}
