import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/core/utils/global_dio_headers_handler.dart';

void main() {
  late GlobalDioHeadersHandler injectedDioOptionsHandler;

  late GetIt getIt;

  setUpAll(() {
    getIt = GetIt.instance;

    getIt.registerLazySingleton(() => Dio());
  });

  setUp(() {
    injectedDioOptionsHandler = GlobalDioHeadersHandler(getItInstance: getIt);
  });

  group(
    "setAuthorization",
    () {
      test(
        "should set Authorization on (injected dio options by getIt)",
        () {
          //arrange

          //act
          injectedDioOptionsHandler.setAuthorization(username: "test", password: "test1234");

          //assert
          expect(
            getIt.get<Dio>().options.headers["Authorization"],
            makeBase64Encode(name: "test", password: "test1234"),
          );
        },
      );
    },
  );

  group("setBaseUrl", () {
    test(
      "should set baseUrl of (injected dio options by getIt) ",
      () {
        //arrange

        //act
        injectedDioOptionsHandler.setBaseUrl("https://example.com");

        //assert
        expect(getIt.get<Dio>().options.baseUrl, "https://example.com");
      },
    );
  });
}
