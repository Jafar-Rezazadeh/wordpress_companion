import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';

import '../../../../../dummy_params.dart';
import '../../../../../json_response_simulator.dart';

class FakePostParams extends Fake implements PostParams {}

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late PostsRemoteDataSourceImpl postsRemoteDataSourceImpl;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: "https://example.com"));
    dioAdapter = DioAdapter(
      dio: dio,
      printLogs: true,
      matcher: const FullHttpRequestMatcher(needsExactBody: true),
    );
    postsRemoteDataSourceImpl = PostsRemoteDataSourceImpl(dio: dio);
  });

  group("createPost -", () {
    test(
        "should return created post as (PostModel) when success with (json) response",
        () async {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/posts",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.created,
          JsonResponseSimulator.post,
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.createPost(
        DummyParams.postParams,
      );

      //assert
      expect(result, isA<PostModel>());
    });

    test(
        "should return created post as (PostModel) when success with (jsonString) response",
        () async {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/posts",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.created,
          jsonEncode(JsonResponseSimulator.post),
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.createPost(
        DummyParams.postParams,
      );

      //assert
      expect(result, isA<PostModel>());
    });

    test("should throw (DioException) when response is a failure", () async {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/posts",
        (server) => server.reply(
          HttpStatus.badRequest,
          null,
        ),
      );

      //act
      final result =
          postsRemoteDataSourceImpl.createPost(DummyParams.postParams);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("deletePost -", () {
    test(
        "should return updated post as(PostModel) when success with (json) response",
        () async {
      //arrange
      final params = DummyParams.postParams;
      dioAdapter.onDelete(
        "$wpV2EndPoint/posts/${params.id}",
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.post,
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.deletePost(params.id);

      //assert
      expect(result, isA<PostModel>());
    });

    test(
        "should return updated post as (PostModel) when success with (jsonString) response",
        () async {
      //arrange
      final params = DummyParams.postParams;
      dioAdapter.onDelete(
        "$wpV2EndPoint/posts/${params.id}",
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.post),
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.deletePost(params.id);

      //assert
      expect(result, isA<PostModel>());
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      final params = DummyParams.postParams;
      dioAdapter.onDelete(
        "$wpV2EndPoint/posts/${params.id}",
        (server) => server.reply(
          HttpStatus.badRequest,
          null,
        ),
      );

      //act
      final result = postsRemoteDataSourceImpl.deletePost(params.id);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("getPostsPerPage -", () {
    test(
        "should return (PostsPageResult) when success with (json) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.post],
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.getPostsPerPage(
        GetPostsPerPageParams(),
      );

      //assert
      expect(result, isA<PostsPageResult>());
    });

    test(
        "should return (PostsPageResult) when success with (jsonString) response data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode([JsonResponseSimulator.post]),
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.getPostsPerPage(
        GetPostsPerPageParams(),
      );

      //assert
      expect(result, isA<PostsPageResult>());
    });

    test(
        "should PostsPageResult.hasNextPage be (true) if current page is less than x-wp-totalpages ",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        (server) => server.reply(
          HttpStatus.ok,
          headers: {
            "x-wp-totalpages": ["9"]
          },
          jsonEncode([JsonResponseSimulator.post]),
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.getPostsPerPage(
        GetPostsPerPageParams(page: 6),
      );

      //assert
      expect(result.hasNextPage, true);
    });
    test(
        "should PostsPageResult.hasNextPage be (false) if current page is NOT less than x-wp-totalpages",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        (server) => server.reply(
          HttpStatus.ok,
          headers: {
            "x-wp-totalpages": ["9"]
          },
          jsonEncode([JsonResponseSimulator.post]),
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.getPostsPerPage(
        GetPostsPerPageParams(page: 9),
      );

      //assert
      expect(result.hasNextPage, false);
    });

    test("should request has expected query params ", () async {
      //arrange
      Map<String, dynamic> params = {};
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          params = options.queryParameters;
          return handler.next(options);
        },
      ));

      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        queryParameters: {
          "page": Matchers.any,
          "per_page": Matchers.any,
        },
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.post],
        ),
      );

      //act
      await postsRemoteDataSourceImpl.getPostsPerPage(
        GetPostsPerPageParams(),
      );

      //assert
      expect(params.keys, contains("page"));
      expect(params.keys, contains("per_page"));
    });

    test(
        "should add nullable params with correct values when they are not null",
        () async {
      //arrange
      var params = {};

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            params = options.queryParameters;
            return handler.next(options);
          },
        ),
      );

      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        queryParameters: {
          "page": Matchers.any,
          "per_page": Matchers.any,
          "search": Matchers.any,
          "after": Matchers.any,
          "before": Matchers.any,
          "categories": "1,2,3",
        },
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.post],
        ),
      );

      //act
      await postsRemoteDataSourceImpl.getPostsPerPage(
        GetPostsPerPageParams(
          search: "test",
          after: "test",
          before: "test",
          categories: [1, 2, 3],
        ),
      );

      //assert
      final expectedKeys = [
        "page",
        "per_page",
        "search",
        "after",
        "before",
        "categories"
      ];
      for (var key in expectedKeys) {
        expect(params.keys, contains(key));
      }
      expect(params["categories"], "1,2,3");
    });

    test("should Not Add Nullable params when they are null", () async {
      //arrange
      var params = {};
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            params = options.queryParameters;
            return handler.next(options);
          },
        ),
      );

      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        queryParameters: {
          "page": Matchers.any,
          "per_page": Matchers.any,
        },
        (server) => server.reply(
          HttpStatus.ok,
          [JsonResponseSimulator.post],
        ),
      );

      //act
      await postsRemoteDataSourceImpl.getPostsPerPage(GetPostsPerPageParams());

      //assert
      final expectedKeys = ["page", "per_page"];
      for (var key in expectedKeys) {
        expect(params.keys, contains(key));
      }
      expect(params.keys.length, expectedKeys.length);
    });

    test("should throw (DioException) when response is a failure", () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/posts",
        (server) => server.reply(
          HttpStatus.badRequest,
          null,
        ),
      );

      //act
      final result = postsRemoteDataSourceImpl.getPostsPerPage(
        GetPostsPerPageParams(),
      );

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("updatePost -", () {
    test(
        "should return updated post as (PostModel) when success with (json) response",
        () async {
      //arrange
      final params = DummyParams.postParams;
      dioAdapter.onPut(
        "$wpV2EndPoint/posts/${params.id}",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.post,
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.updatePost(params);

      //assert
      expect(result, isA<PostModel>());
    });

    test(
        "should return updated post as (PostModel) when success with (jsonString) response",
        () async {
      //arrange
      final params = DummyParams.postParams;
      dioAdapter.onPut(
        "$wpV2EndPoint/posts/${params.id}",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.post),
        ),
      );

      //act
      final result = await postsRemoteDataSourceImpl.updatePost(params);

      //assert
      expect(result, isA<PostModel>());
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      final params = DummyParams.postParams;
      dioAdapter.onPut(
        "$wpV2EndPoint/posts/${params.id}",
        (server) => server.reply(
          HttpStatus.badRequest,
          null,
        ),
      );

      //act
      final result = postsRemoteDataSourceImpl.updatePost(params);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });
}
