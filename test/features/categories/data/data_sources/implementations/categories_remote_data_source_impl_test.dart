import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

import '../../../../../json_response_simulator.dart';

class FakeCreateOrUpdateCategoryParams extends Fake
    implements CreateOrUpdateCategoryParams {}

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late CategoriesRemoteDataSourceImpl categoriesRemoteDataSourceImpl;
  final fakeCreateUpdateParams = CreateOrUpdateCategoryParams(
    id: 6,
    description: "description",
    name: "name",
    slug: "slug",
    parent: 0,
  );

  setUp(() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://example.com",
      ),
    );

    dioAdapter = DioAdapter(
      dio: dio,
      printLogs: true,
      matcher: const FullHttpRequestMatcher(needsExactBody: true),
    );

    categoriesRemoteDataSourceImpl = CategoriesRemoteDataSourceImpl(dio: dio);
  });

  group("createCategory -", () {
    test("should return (CategoryModel) when success with (json) response",
        () async {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/categories",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.created,
          JsonResponseSimulator.category,
        ),
      );

      //act
      final result = await categoriesRemoteDataSourceImpl
          .createCategory(fakeCreateUpdateParams);

      //assert
      expect(result, isA<CategoryModel>());
    });

    test(
        "should return (CategoryModel) when success with (jsonString) response",
        () async {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/categories",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.created,
          jsonEncode(JsonResponseSimulator.category),
        ),
      );

      //act
      final result = await categoriesRemoteDataSourceImpl
          .createCategory(fakeCreateUpdateParams);

      //assert
      expect(result, isA<CategoryModel>());
    });

    test("should throw (DioException) when api response is a failure", () {
      //arrange
      dioAdapter.onPost(
        "$wpV2EndPoint/categories",
        data: Matchers.any,
        (server) => server.reply(
          HttpStatus.badRequest,
          null,
        ),
      );

      //act
      final result =
          categoriesRemoteDataSourceImpl.createCategory(fakeCreateUpdateParams);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("deleteCategory -", () {
    test(
        "should return (bool) when request is success with (json) response data",
        () async {
      //arrange
      dioAdapter.onDelete(
        "$wpV2EndPoint/categories/${fakeCreateUpdateParams.id}",
        queryParameters: {
          "force": true,
        },
        (server) => server.reply(
          HttpStatus.ok,
          {
            "deleted": true,
          },
        ),
      );

      //act
      final result = await categoriesRemoteDataSourceImpl
          .deleteCategory(fakeCreateUpdateParams.id);

      //assert
      expect(result, isA<bool>());
    });

    test(
        "should return (bool) when request is success with (jsonString) response data",
        () async {
      //arrange
      dioAdapter.onDelete(
        "$wpV2EndPoint/categories/${fakeCreateUpdateParams.id}",
        queryParameters: {
          "force": true,
        },
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode({
            "deleted": true,
          }),
        ),
      );

      //act
      final result = await categoriesRemoteDataSourceImpl
          .deleteCategory(fakeCreateUpdateParams.id);

      //assert
      expect(result, isA<bool>());
    });

    test("should contain (force = true) queryParam", () async {
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

      dioAdapter.onDelete(
        "$wpV2EndPoint/categories/${fakeCreateUpdateParams.id}",
        queryParameters: {
          "force": true,
        },
        (server) => server.reply(
          HttpStatus.ok,
          {
            "deleted": true,
          },
        ),
      );

      //act
      await categoriesRemoteDataSourceImpl
          .deleteCategory(fakeCreateUpdateParams.id);

      //assert
      expect(params.keys, contains("force"));
      expect(params["force"], true);
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      dioAdapter.onDelete(
        "$wpV2EndPoint/categories/${fakeCreateUpdateParams.id}",
        (server) => server.reply(
          HttpStatus.badGateway,
          null,
        ),
      );

      //act
      final result = categoriesRemoteDataSourceImpl
          .deleteCategory(fakeCreateUpdateParams.id);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("getAllCategories -", () {
    group("response data -", () {
      test(
          "should return (List<CategoryModel>) when success with (json) response data",
          () async {
        //arrange
        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          (server) => server.reply(
            HttpStatus.ok,
            [JsonResponseSimulator.category],
          ),
        );

        //act
        final result = await categoriesRemoteDataSourceImpl
            .getAllCategories(GetAllCategoriesParams());

        //assert
        expect(result, isA<List<CategoryModel>>());
      });

      test(
          "should return (List<CategoryModel>) when success with (jsonString) response data",
          () async {
        //arrange
        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          (server) => server.reply(
            HttpStatus.ok,
            jsonEncode([JsonResponseSimulator.category]),
          ),
        );

        //act
        final result = await categoriesRemoteDataSourceImpl
            .getAllCategories(GetAllCategoriesParams());

        //assert
        expect(result, isA<List<CategoryModel>>());
      });

      test("should throw (DioException) when response is a failure", () {
        //arrange
        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          (server) => server.reply(
            HttpStatus.badGateway,
            null,
          ),
        );

        //act
        final result = categoriesRemoteDataSourceImpl
            .getAllCategories(GetAllCategoriesParams());

        //assert
        expect(result, throwsA(isA<DioException>()));
      });
    });

    group("queryParams -", () {
      test("should contain Expected queryParams ", () async {
        //arrange
        var params = {};
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              params = options.queryParameters;
              handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          (server) => server.reply(
            HttpStatus.ok,
            [JsonResponseSimulator.category],
          ),
        );

        //act
        await categoriesRemoteDataSourceImpl
            .getAllCategories(GetAllCategoriesParams());

        //assert
        expect(params.keys, contains("page"));
        expect(params.keys, contains("per_page"));
        expect(params["per_page"], 100);
      });

      test(
          "should include nullable Params to queryParams when they are not not",
          () async {
        //arrange
        var params = {};
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              params = options.queryParameters;
              handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          (server) => server.reply(
            HttpStatus.ok,
            [JsonResponseSimulator.category],
          ),
        );

        //act
        await categoriesRemoteDataSourceImpl.getAllCategories(
          GetAllCategoriesParams(
            orderby: CategoryOrderByEnum.slug,
            search: "search",
          ),
        );

        //assert
        expect(params.keys, contains("orderby"));
        expect(params["orderby"], "slug");
        expect(params.keys, contains("search"));
      });

      test("should NOT include null Params to queryParams when they are null",
          () async {
        //arrange
        var params = {};
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              params = options.queryParameters;
              handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          (server) => server.reply(
            HttpStatus.ok,
            [JsonResponseSimulator.category],
          ),
        );

        //act
        await categoriesRemoteDataSourceImpl
            .getAllCategories(GetAllCategoriesParams());

        //assert
        expect(params.keys, isNot(contains("orderby")));

        expect(params.keys, isNot(contains("search")));
      });
    });

    group("page increment", () {
      test(
          "should send request when (page < x-wp-totalPages) and return all pages data",
          () async {
        //arrange
        int currentPage = 0;

        var headers = {
          Headers.contentTypeHeader: [Headers.jsonContentType],
          "x-wp-totalpages": ["2"],
        };

        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              currentPage = options.queryParameters["page"];
              handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          queryParameters: {"page": 1},
          (server) => server.reply(
            HttpStatus.ok,
            headers: headers,
            [JsonResponseSimulator.category],
          ),
        );

        dioAdapter.onGet(
          "$wpV2EndPoint/categories",
          queryParameters: {"page": 2},
          (server) => server.reply(
            HttpStatus.ok,
            headers: headers,
            [JsonResponseSimulator.category],
          ),
        );

        //act
        final result = await categoriesRemoteDataSourceImpl
            .getAllCategories(GetAllCategoriesParams());

        //assert
        expect(currentPage, 2);
        expect(result.length, 2);
      });
    });
  });

  group("updateCategory -", () {
    test("should return (CategoryModel) when success with (json) response data",
        () async {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/categories/${fakeCreateUpdateParams.id}",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.category,
        ),
      );

      //act
      final result = await categoriesRemoteDataSourceImpl
          .updateCategory(fakeCreateUpdateParams);

      //assert
      expect(result, isA<CategoryModel>());
    });

    test(
        "should return (CategoryModel) when success with (jsonString) response data",
        () async {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/categories/${fakeCreateUpdateParams.id}",
        data: Matchers.isA<Map<String, dynamic>>(),
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.category),
        ),
      );

      //act
      final result = await categoriesRemoteDataSourceImpl
          .updateCategory(fakeCreateUpdateParams);

      //assert
      expect(result, isA<CategoryModel>());
    });

    test("should throw (DioException) when response is a failure", () {
      //arrange
      dioAdapter.onPut(
        "$wpV2EndPoint/categories",
        data: Matchers.any,
        (server) => server.reply(
          HttpStatus.badGateway,
          null,
        ),
      );

      //act
      final result =
          categoriesRemoteDataSourceImpl.updateCategory(fakeCreateUpdateParams);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });
}
