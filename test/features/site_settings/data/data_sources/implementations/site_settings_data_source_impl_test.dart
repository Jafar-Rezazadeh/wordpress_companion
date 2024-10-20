import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/site_settings/site_settings_exports.dart';

import '../../../../../dummy_params.dart';
import '../../../../../json_response_simulator.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late SiteSettingsDataSourceImpl siteSettingsDataSourceImpl;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: "https://example.com"));
    dioAdapter = DioAdapter(
      dio: dio,
      printLogs: true,
      matcher: const FullHttpRequestMatcher(needsExactBody: true),
    );
    siteSettingsDataSourceImpl = SiteSettingsDataSourceImpl(dio: dio);
  });

  group("getSettings -", () {
    test(
        "should return the (SiteSettingsModel) when success to fetch settings with json response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/settings",
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.siteSettings,
        ),
      );

      //act
      final result = await siteSettingsDataSourceImpl.getSettings();

      //assert
      expect(result, isA<SiteSettingsModel>());
    });

    test("should return (SiteSettingsModel) when response is JsonString",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/settings",
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.siteSettings),
        ),
      );

      //act
      final result = await siteSettingsDataSourceImpl.getSettings();

      //assert
      expect(result, isA<SiteSettingsModel>());
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/settings",
        (server) => server.reply(
          HttpStatus.internalServerError,
          null,
        ),
      );

      //act
      final result = siteSettingsDataSourceImpl.getSettings();

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("updateSettings -", () {
    test(
        "should return updated data as (SiteSettingsModel) when success to updated ",
        () async {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/settings",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.siteSettings,
        ),
      );

      //act
      final result = await siteSettingsDataSourceImpl.updateSettings(
        DummyParams.updateSiteSettingsParams,
      );

      //assert
      expect(result, isA<SiteSettingsModel>());
    });

    test(
        "should return updated data as (SiteSettingsModel) when response is jsonString",
        () async {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/settings",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.siteSettings),
        ),
      );

      //act
      final result = await siteSettingsDataSourceImpl.updateSettings(
        DummyParams.updateSiteSettingsParams,
      );

      //assert
      expect(result, isA<SiteSettingsModel>());
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/settings",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.internalServerError,
          null,
        ),
      );

      //act
      final result = siteSettingsDataSourceImpl.updateSettings(
        DummyParams.updateSiteSettingsParams,
      );

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });
}
