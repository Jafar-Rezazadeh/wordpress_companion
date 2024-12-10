import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

import '../../../../../dummy_stuff.dart';
import '../../../../../json_response_simulator.dart';

class FakeUpdateMyProfileParams extends Fake implements UpdateMyProfileParams {}

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;

  setUp(() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://example.com",
        queryParameters: {"context": "edit"},
      ),
    );
    dioAdapter = DioAdapter(
      dio: dio,
      printLogs: true,
      matcher: const FullHttpRequestMatcher(needsExactBody: true),
    );
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(dio: dio);
  });

  group("getMyProfile -", () {
    test("should fetch the data and return(ProfileModel) when success",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/users/me",
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.profile,
        ),
      );

      //act
      final result = await profileRemoteDataSourceImpl.getMyProfile();

      //assert
      expect(result, isA<ProfileModel>());
    });

    test(
        "should fetch the data and return(ProfileModel) when success with (Json) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/users/me",
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.profile,
        ),
      );

      //act
      final result = await profileRemoteDataSourceImpl.getMyProfile();

      //assert
      expect(result, isA<ProfileModel>());
    });
    test(
        "should fetch the data and return(ProfileModel) when success with (JsonString) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/users/me",
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.profile),
        ),
      );

      //act
      final result = await profileRemoteDataSourceImpl.getMyProfile();

      //assert
      expect(result, isA<ProfileModel>());
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/users/me",
        (server) => server.reply(
          HttpStatus.unauthorized,
          null,
        ),
      );

      //act
      final result = profileRemoteDataSourceImpl.getMyProfile();

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("updateMyProfile -", () {
    test(
        "should return updated profile as (ProfileModel) when success to update with (json) response data",
        () async {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/users/me",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.profile,
        ),
      );

      //act
      final result = await profileRemoteDataSourceImpl.updateMyProfile(
        DummyParams.updateMyProfileParams,
      );

      //assert
      expect(result, isA<ProfileModel>());
    });
    test(
        "should return updated profile as (ProfileModel) when success to update with (jsonString) response data",
        () async {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/users/me",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.profile),
        ),
      );

      //act
      final result = await profileRemoteDataSourceImpl.updateMyProfile(
        DummyParams.updateMyProfileParams,
      );

      //assert
      expect(result, isA<ProfileModel>());
    });

    test("should throw (DioException) when server response a failure", () {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/users/me",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.badGateway,
          null,
        ),
      );

      //act
      final result = profileRemoteDataSourceImpl.updateMyProfile(
        DummyParams.updateMyProfileParams,
      );

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });
}
