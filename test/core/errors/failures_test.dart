import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/errors/failures.dart';

void main() {
  group("FailureFactory -", () {
    test("should return (ServerFailure) when object is (DioException)", () {
      //arrange
      final object = DioException(
        requestOptions: RequestOptions(),
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          statusMessage: "not Found",
        ),
      );

      //act
      final result = FailureFactory.createFailure(object);

      //assert
      expect(result, isA<ServerFailure>());
      expect(result.response, isNot(null));
    });

    test(
        "should return (InternalFailure) when object is Not (DioException) anything else",
        () {
      //act
      final result = FailureFactory.createFailure(TypeError());

      //assert
      expect(result, isA<InternalFailure>());
      expect(result.response, isNull);
    });
  });

  group("ServerFailure -", () {
    test("should all properties be in (props)", () {
      //arrange
      final failure = ServerFailure(
        message: "",
        response: Response(requestOptions: RequestOptions()),
        stackTrace: StackTrace.fromString("hello"),
      );

      //act
      final props = failure.props;

      //assert
      expect(
        props,
        containsAll([isA<String>(), isA<Response>(), isA<StackTrace>()]),
      );
    });
  });

  group("InternalFailure -", () {
    test("should all properties be in (props) ", () {
      //arrange
      final failure = InternalFailure(
        message: "",
        stackTrace: StackTrace.fromString("hello"),
      );

      //act
      final props = failure.props;

      //assert
      expect(
        props,
        containsAll([isA<String>(), isA<StackTrace>()]),
      );
    });
  });
}
