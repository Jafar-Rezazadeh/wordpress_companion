import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

import '../../../../../json_response_simulator.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions(baseUrl: "https://example.com");
}

class MockCancelToken extends Mock implements CancelToken {}

void main() {
  const dummyAssetFileForUpload = "assets/fonts/Vazir.ttf";
  late Dio dio;
  late DioAdapter dioAdapter;
  late MediaRemoteDataSourceImpl mediaRemoteDataSourceImpl;
  late MockCancelToken mockCancelToken;

  setUp(() {
    mockCancelToken = MockCancelToken();
    dio = Dio(BaseOptions(baseUrl: "https://example.com"));
    dioAdapter = DioAdapter(
      dio: dio,
      printLogs: true,
      matcher: const FullHttpRequestMatcher(needsExactBody: true),
    );
    mediaRemoteDataSourceImpl = MediaRemoteDataSourceImpl(dio: dio);
  });

  group("deleteMedia -", () {
    test("should return (bool) when success to call api with out any failure",
        () async {
      //arrange
      const int id = 1;
      dioAdapter.onDelete(
        "$wpV2EndPoint/media/$id",
        queryParameters: {
          "force": "true",
        },
        (server) => server.reply(
          HttpStatus.ok,
          {
            "deleted": true,
            "previous": {},
          },
        ),
      );

      //act
      final result = await mediaRemoteDataSourceImpl.deleteMedia(id);

      //assert
      expect(result, true);
    });
    test(
        "should convert the response data to Map<String,dynamic) when data is jsonString",
        () async {
      //arrange
      const id = 1;
      dioAdapter.onDelete(
        "$wpV2EndPoint/media/$id",
        queryParameters: {
          "force": "true",
        },
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode({
            "deleted": true,
            "previous": {},
          }),
        ),
      );

      //act
      final result = await mediaRemoteDataSourceImpl.deleteMedia(id);

      //assert
      expect(result, true);
    });

    test("should throw (DioException) when api response is a failure",
        () async {
      //arrange
      const id = 1;
      dioAdapter.onDelete(
        "$wpV2EndPoint/media/$id",
        queryParameters: {
          "force": "true",
        },
        (server) => server.reply(
          HttpStatus.notFound,
          null,
        ),
      );

      //act
      final result = mediaRemoteDataSourceImpl.deleteMedia(id);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("getMediasPerPage -", () {
    test("should return (CurrentPageMediasEntity) when success to get data",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/media",
        queryParameters: {
          "per_page": Matchers.any,
          "page": Matchers.any,
        },
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.mediaList,
        ),
      );
      //act
      final result = await mediaRemoteDataSourceImpl.getMediasPerPage(
        GetMediaPerPageParams(),
      );

      //assert
      expect(result, isA<CurrentPageMediasEntity>());
      expect(result.medias, isNotEmpty);
    });

    test(
        "should convert the to Map<String,dynamic> when  response data is jsonString",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/media",
        queryParameters: {
          "per_page": Matchers.any,
          "page": Matchers.any,
        },
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.mediaList),
        ),
      );

      //act
      final result = await mediaRemoteDataSourceImpl.getMediasPerPage(
        GetMediaPerPageParams(),
      );

      //assert
      expect(result, isA<CurrentPageMediasEntity>());
      expect(result.medias, isNotEmpty);
    });

    group("queryParameters -", () {
      test("should include _embed=author to queryParams ", () async {
        //arrange
        Map<String, dynamic>? queryParams;
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              queryParams = options.queryParameters;
              handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/media",
          (server) => server.reply(
            HttpStatus.ok,
            JsonResponseSimulator.mediaList,
          ),
        );

        //act
        await mediaRemoteDataSourceImpl.getMediasPerPage(
          GetMediaPerPageParams(),
        );

        //assert
        expect(queryParams?.keys, contains("_embed"));
        expect(queryParams?["_embed"], "author");
      });

      test("should include the perPage and page to queryParameters ", () async {
        //arrange
        Map<String, dynamic>? queryParams;
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              queryParams = options.queryParameters;
              handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/media",
          (server) => server.reply(
            HttpStatus.ok,
            JsonResponseSimulator.mediaList,
          ),
        );

        //act
        await mediaRemoteDataSourceImpl.getMediasPerPage(
          GetMediaPerPageParams(),
        );

        //assert
        for (var param in ["per_page", "page"]) {
          expect(queryParams?.keys, contains(param));
        }
      });

      test(
          "should include nullable params in queryParams when they are not null",
          () async {
        //arrange
        Map<String, dynamic>? queryParams;
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              queryParams = options.queryParameters;
              handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/media",
          (server) => server.reply(
            HttpStatus.ok,
            JsonResponseSimulator.mediaList,
          ),
        );

        //act
        await mediaRemoteDataSourceImpl.getMediasPerPage(
          GetMediaPerPageParams(
            search: "search",
            after: "after",
            before: "before",
            type: MediaType.text,
          ),
        );

        //assert
        final expectedParams = [
          "per_page",
          "page",
          "search",
          "after",
          "before",
          "media_type",
        ];
        for (var param in expectedParams) {
          expect(queryParams?.keys, contains(param));
        }
      });

      test("should NOT include any null param in queryParams ", () async {
        //arrange
        Map<String, dynamic>? queryParams;
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              queryParams = options.queryParameters;
              return handler.next(options);
            },
          ),
        );
        dioAdapter.onGet(
          "$wpV2EndPoint/media",
          (server) => server.reply(
            HttpStatus.ok,
            JsonResponseSimulator.mediaList,
          ),
        );

        //act
        await mediaRemoteDataSourceImpl.getMediasPerPage(
          GetMediaPerPageParams(),
        );

        //assert
        for (var param in ["per_page", "page", "_embed"]) {
          expect(queryParams?.keys, contains(param));
        }
        expect(queryParams?.length, 3);
      });
    });

    group("hasMoreMedias -", () {
      test(
          "should CurrentPageMediasEntity (hasNextPage = false) when the current page is Not less than total pages",
          () async {
        //arrange
        dioAdapter.onGet(
          "$wpV2EndPoint/media",
          queryParameters: {
            "per_page": Matchers.any,
            "page": Matchers.any,
          },
          (server) => server.reply(
            HttpStatus.ok,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
              "x-wp-totalpages": ["1"],
            },
            [JsonResponseSimulator.media],
          ),
        );

        //act
        final result = await mediaRemoteDataSourceImpl.getMediasPerPage(
          GetMediaPerPageParams(perPage: 10, page: 1),
        );

        //assert
        expect(result.hasNextPage, false);
      });

      test(
          "should currentPageMediasEntity (hasMoreMedias = true) when the length of received medias is equal or grater than perPage",
          () async {
        //arrange
        dioAdapter.onGet(
          "$wpV2EndPoint/media",
          queryParameters: {
            "per_page": Matchers.any,
            "page": Matchers.any,
          },
          (server) => server.reply(
            HttpStatus.ok,
            headers: {
              Headers.contentTypeHeader: [Headers.jsonContentType],
              "x-wp-totalpages": ["10"],
            },
            [JsonResponseSimulator.media],
          ),
        );

        //act
        final result = await mediaRemoteDataSourceImpl.getMediasPerPage(
          GetMediaPerPageParams(perPage: 10, page: 1),
        );

        //assert
        expect(result.hasNextPage, true);
      });
    });
  });

  group("updateMedia -", () {
    test("should return updated media as (MediaModel) when update success",
        () async {
      //arrange
      const params = UpdateMediaParams(
        id: 2,
        altText: "altText",
        title: "title",
        caption: "caption",
        description: "description",
      );

      dioAdapter.onPut(
        "$wpV2EndPoint/media/${params.id}",
        data: Matchers.any,
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.media,
        ),
      );

      //act
      final result = await mediaRemoteDataSourceImpl.updateMedia(params);

      //assert
      expect(result, isA<MediaModel>());
    });

    test("should convert the (MediaModel) when response data is jsonString",
        () async {
      //arrange
      const params = UpdateMediaParams(
        id: 2,
        altText: "altText",
        title: "title",
        caption: "caption",
        description: "description",
      );

      dioAdapter.onPut(
        "$wpV2EndPoint/media/${params.id}",
        data: Matchers.any,
        (server) => server.reply(
          HttpStatus.ok,
          jsonEncode(JsonResponseSimulator.media),
        ),
      );

      //act
      final result = await mediaRemoteDataSourceImpl.updateMedia(params);

      //assert
      expect(result, isA<MediaModel>());
    });

    test("should throw (DioException) when api response is a failure", () {
      //arrange
      const params = UpdateMediaParams(
        id: 5,
        altText: "altText",
        title: "title",
        caption: "caption",
        description: "description",
      );
      dioAdapter.onPut(
        "$wpV2EndPoint/media/${params.id}",
        data: Matchers.any,
        (server) => server.reply(HttpStatus.notFound, null),
      );

      //act
      final result = mediaRemoteDataSourceImpl.updateMedia(params);

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });

  group("uploadMediaFile -", () {
    test('uploads file and returns progress stream', () async {
      // arrange
      final dio = MockDio();
      final mediaRemoteDataSourceImpl = MediaRemoteDataSourceImpl(dio: dio);

      when(
        () => dio.post(
          "$wpV2EndPoint/media",
          data: any(named: 'data'),
          options: any(named: 'options'),
          onSendProgress: any(named: 'onSendProgress'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((invocation) async {
        final onSendProgress = invocation
            .namedArguments[const Symbol('onSendProgress')] as ProgressCallback;

        onSendProgress(50, 100);
        onSendProgress(100, 100);

        return Response(
          statusCode: HttpStatus.ok,
          data: JsonResponseSimulator.media,
          requestOptions: RequestOptions(),
        );
      });

      // act
      final result = await mediaRemoteDataSourceImpl
          .uploadMediaFile(dummyAssetFileForUpload)
          .stream
          .toList();

      // assert
      expect(result, [0.5, 1.0]);
    });
    test("should include expected headers ", () async {
      //arrange
      var headers = {};
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            headers = options.headers;
            handler.next(options);
          },
        ),
      );
      dioAdapter.onPost(
        "$wpV2EndPoint/media",
        data: Matchers.any,
        (server) => server.reply(
          HttpStatus.ok,
          JsonResponseSimulator.media,
        ),
      );

      //act
      await mediaRemoteDataSourceImpl
          .uploadMediaFile(dummyAssetFileForUpload)
          .stream
          .toList();

      //assert
      expect(headers.keys, contains("content-type"));
      expect(
        headers["content-type"].toString(),
        contains("multipart/form-data"),
      );
    });
  });

  group("cancelUploadMediaFile -", () {
    test("should invoke the cancelToken when called", () async {
      //arrange
      when(
        () => mockCancelToken.cancel(),
      ).thenAnswer((_) async {});

      //act
      await mediaRemoteDataSourceImpl.cancelMediaUpload(mockCancelToken);

      //assert
      verify(() => mockCancelToken.cancel(any())).called(1);
    });
  });
}
