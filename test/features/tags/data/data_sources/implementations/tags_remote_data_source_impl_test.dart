import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

import '../../../../../json_response_simulator.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late TagsRemoteDataSourceImpl tagsRemoteDataSourceImpl;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: "https://example.com"));
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const FullHttpRequestMatcher(needsExactBody: true),
      printLogs: true,
    );

    tagsRemoteDataSourceImpl = TagsRemoteDataSourceImpl(dio: dio);
  });

  group("createTag -", () {
    test(
        "should return created tag as(TagModel) when success with (json) response data",
        () async {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/tags",
        data: Matchers.any,
        (server) => server.reply(HttpStatus.created, JsonResponseSimulator.tag),
      );

      //act
      final result = await tagsRemoteDataSourceImpl.createTag("name");

      //assert
      expect(result, isA<TagModel>());
    });

    test(
        "should return created tag as (TagModel) when success with (jsonString) response data",
        () async {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/tags",
        data: Matchers.any,
        (server) => server.reply(
          HttpStatus.created,
          jsonEncode(JsonResponseSimulator.tag),
        ),
      );

      //act
      final result = await tagsRemoteDataSourceImpl.createTag("name");

      //assert
      expect(result, isA<TagModel>());
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/tags",
        data: Matchers.any,
        (server) => server.reply(
          HttpStatus.badGateway,
          null,
        ),
      );

      //act
      final result = tagsRemoteDataSourceImpl.createTag("name");

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("getTagsByIds -", () {
    test("should request contain the (include) with given ids param ",
        () async {
      //arrange
      Map<String, dynamic> queryParams = {};

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            queryParams = options.queryParameters;
            handler.next(options);
          },
        ),
      );
      dioAdapter.onGet(
        "$wpV2EndPoint/tags",
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.tag],
        ),
      );

      //act
      await tagsRemoteDataSourceImpl.getTagsByIds([5, 2]);

      //assert
      expect(queryParams.keys, contains("include"));
      expect(queryParams["include"], "5,2");
    });

    test("should return empty List when input is empty List", () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/tags",
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.tag],
        ),
      );

      //act
      final result = await tagsRemoteDataSourceImpl.getTagsByIds([]);

      //assert
      expect(result, isEmpty);
    });

    test(
        "should return (List<TagModel>) when success with (json) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/tags",
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.tag],
        ),
      );

      //act
      final result = await tagsRemoteDataSourceImpl.getTagsByIds([55]);

      //assert
      expect(result, isA<List<TagModel>>());
      expect(result.length, 1);
    });
    test(
        "should return (List<TagModel>) when success with (jsonString) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/tags",
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode([JsonResponseSimulator.tag]),
        ),
      );

      //act
      final result = await tagsRemoteDataSourceImpl.getTagsByIds([55]);

      //assert
      expect(result, isA<List<TagModel>>());
      expect(result.length, 1);
    });
  });

  group("searchTag -", () {
    test("should request contain (search) param with the given value",
        () async {
      //arrange
      Map<String, dynamic> params = {};

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            params = options.queryParameters;
            handler.next(options);
          },
        ),
      );
      dioAdapter.onGet(
        "$wpV2EndPoint/tags",
        (server) => server.reply(
          HttpStatus.ok,
          [],
        ),
      );

      //act
      await tagsRemoteDataSourceImpl.searchTag("value");

      //assert
      expect(params.keys, contains("search"));
      expect(params["search"], "value");
    });

    test(
        "should return (List<TagModel>) when success with (json) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/tags",
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.tag],
        ),
      );

      //act
      final result = await tagsRemoteDataSourceImpl.searchTag("value");

      //assert
      expect(result, isA<List<TagModel>>());
      expect(result.length, 1);
    });

    test(
        "should return (List<TagModel>) when success with (jsonString) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/tags",
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode([JsonResponseSimulator.tag]),
        ),
      );

      //act
      final result = await tagsRemoteDataSourceImpl.searchTag("value");

      //assert
      expect(result, isA<List<TagModel>>());
      expect(result.length, 1);
    });
  });
}
