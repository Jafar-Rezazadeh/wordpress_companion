import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/constants/enums.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

import '../../../../../json_response_simulator.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions(baseUrl: "https://example.com");
}

void main() {
  const dummyAssetFileForUpload = "assets/fonts/Vazir.ttf";
  late Dio dio;
  late DioAdapter dioAdapter;
  late MediaRemoteDataSourceImpl mediaRemoteDataSourceImpl;

  setUp(() {
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

    test("should include the perPage and page to queryParameters ", () async {
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
      await mediaRemoteDataSourceImpl.getMediasPerPage(
        GetMediaPerPageParams(),
      );
      final queryParams = dioAdapter.history.first.request.queryParameters;

      //assert
      expect(queryParams?.keys, containsAll(["per_page", "page"]));
    });

    test("should include nullable params in queryParams when they are not null",
        () async {
      //arrange
      dioAdapter.onGet(
        "$wpV2EndPoint/media",
        queryParameters: {
          "per_page": Matchers.any,
          "page": Matchers.any,
          "search": Matchers.any,
          "after": Matchers.any,
          "before": Matchers.any,
          "media_type": Matchers.any,
        },
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
      final queryParams = dioAdapter.history.first.request.queryParameters;

      //assert
      expect(
        queryParams?.keys,
        containsAll([
          "per_page",
          "page",
          "search",
          "after",
          "before",
          "media_type",
        ]),
      );
    });

    test("should NOT include any null param in queryParams ", () async {
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
      await mediaRemoteDataSourceImpl.getMediasPerPage(
        GetMediaPerPageParams(),
      );
      final queryParams = dioAdapter.history.first.request.queryParameters;

      //assert
      expect(queryParams?.keys, containsAll(["per_page", "page"]));
      expect(queryParams?.length, 2);
    });

    test(
        "should CurrentPageMediasEntity (hasMore = false) when the length of received medias is less than perPage",
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
          List.generate(3, (index) => JsonResponseSimulator.media),
        ),
      );

      //act
      final result = await mediaRemoteDataSourceImpl.getMediasPerPage(
        GetMediaPerPageParams(perPage: 10),
      );

      //assert
      expect(result.hasMoreMedias, false);
    });

    test(
        "should currentPageMediasEntity (hasMore = true) when the length of received medias is equal or grater than perPage",
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
          List.generate(10, (index) => JsonResponseSimulator.media),
        ),
      );

      //act
      final result = await mediaRemoteDataSourceImpl.getMediasPerPage(
        GetMediaPerPageParams(perPage: 10),
      );

      //assert
      expect(result.hasMoreMedias, true);
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
          .toList();

      //assert
      expect(headers.keys, contains("content-type"));
      expect(
        headers["content-type"].toString(),
        contains("multipart/form-data"),
      );
    });
  });
}
