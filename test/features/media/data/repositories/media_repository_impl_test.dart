import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRemoteDataSource extends Mock implements MediaRemoteDataSource {}

class MockCancelToken extends Mock implements CancelToken {}

class FakeUpdateMediaParams extends Fake implements UpdateMediaParams {}

class FakeMediaModel extends Fake implements MediaModel {}

class FakeCurrentPageMediasEntity extends Fake
    implements CurrentPageMediasEntity {}

void main() {
  late MockMediaRemoteDataSource mockMediaRemoteDataSource;
  late MockCancelToken mockCancelToken;
  late MediaRepositoryImpl mediaRepositoryImpl;

  setUpAll(() {
    registerFallbackValue(FakeUpdateMediaParams());
    registerFallbackValue(GetMediaPerPageParams());
    registerFallbackValue(MockCancelToken());
  });

  setUp(() {
    mockMediaRemoteDataSource = MockMediaRemoteDataSource();
    mockCancelToken = MockCancelToken();
    mediaRepositoryImpl = MediaRepositoryImpl(
      mediaRemoteDataSource: mockMediaRemoteDataSource,
    );
  });

  group("deleteMedia -", () {
    test("should return a (bool) when api calls success", () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.deleteMedia(any()),
      ).thenAnswer((_) async => true);

      //act
      final result = await mediaRepositoryImpl.deleteMedia(1);
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<bool>());
    });

    test("should return (ServerFailure) when DioException thrown", () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.deleteMedia(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await mediaRepositoryImpl.deleteMedia(1);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test(
        "should return (InternalFailure) when anything else except DioException thrown",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.deleteMedia(any()),
      ).thenThrow(TypeError());

      //act
      final result = await mediaRepositoryImpl.deleteMedia(2);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("getAllMedia -", () {
    test("should return (CurrentPageMediasEntity) when success to get data",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.getMediasPerPage(any()),
      ).thenAnswer((_) async => FakeCurrentPageMediasEntity());

      //act
      final result =
          await mediaRepositoryImpl.getMediaPerPage(GetMediaPerPageParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<CurrentPageMediasEntity>());
    });

    test("should return (ServerFailure) when DioException thrown", () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.getMediasPerPage(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result =
          await mediaRepositoryImpl.getMediaPerPage(GetMediaPerPageParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when anything else is thrown",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.getMediasPerPage(any()),
      ).thenThrow(TypeError());

      //act
      final result =
          await mediaRepositoryImpl.getMediaPerPage(GetMediaPerPageParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("updateMedia -", () {
    test("should return (MediaEntity) when success to update", () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.updateMedia(any()),
      ).thenAnswer((_) async => FakeMediaModel());

      //act
      final result = await mediaRepositoryImpl.updateMedia(
        FakeUpdateMediaParams(),
      );
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<MediaEntity>());
    });

    test("should return (ServerFailure) when DioException is thrown", () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.updateMedia(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await mediaRepositoryImpl.updateMedia(
        FakeUpdateMediaParams(),
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when any other exception is thrown",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.updateMedia(any()),
      ).thenThrow(TypeError());

      //act
      final result = await mediaRepositoryImpl.updateMedia(
        FakeUpdateMediaParams(),
      );
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("uploadMediaFile -", () {
    test(
        "should return upload progress as (UploadMediaResult) when start to upload",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.uploadMediaFile(any()),
      ).thenAnswer(
        (_) => (cancelToken: mockCancelToken, stream: const Stream.empty()),
      );

      //act
      final result = await mediaRepositoryImpl.uploadMediaFile("path");
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<UploadMediaResult>());
    });

    test("should return (ServerFailure) when DioException is thrown ",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.uploadMediaFile(any()),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      //act
      final result = await mediaRepositoryImpl.uploadMediaFile("pathToFile");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when any other exception is thrown",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.uploadMediaFile("pathToFile"),
      ).thenThrow(TypeError());

      //act
      final result = await mediaRepositoryImpl.uploadMediaFile("pathToFile");
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });

  group("cancelMediaUpload -", () {
    test("should return (void) when success to cancel", () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.cancelMediaUpload(any()),
      ).thenAnswer((_) async {});

      //act
      final result =
          await mediaRepositoryImpl.cancelMediaUpload(mockCancelToken);

      //assert
      expect(result.isRight(), true);
    });

    test("should return (ServerFailure) when DioException thrown", () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.cancelMediaUpload(any()),
      ).thenAnswer(
          (_) async => throw DioException(requestOptions: RequestOptions()));

      //act
      final result =
          await mediaRepositoryImpl.cancelMediaUpload(mockCancelToken);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<ServerFailure>());
    });

    test("should return (InternalFailure) when any other exception is thrown",
        () async {
      //arrange
      when(
        () => mockMediaRemoteDataSource.cancelMediaUpload(any()),
      ).thenAnswer((_) async => throw TypeError());

      //act
      final result =
          await mediaRepositoryImpl.cancelMediaUpload(mockCancelToken);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<InternalFailure>());
    });
  });
}
