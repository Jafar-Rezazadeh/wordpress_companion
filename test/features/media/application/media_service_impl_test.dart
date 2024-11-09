import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/application/media_service_impl.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockGetMediaPerPage extends Mock implements GetMediaPerPage {}

class MockGetSingleMedia extends Mock implements GetSingleMedia {}

class FakeCurrentPageMediasEntity extends Fake implements CurrentPageMedias {}

class FakeMediaEntity extends Fake implements MediaEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockGetMediaPerPage mockGetMediaPerPage;
  late MockGetSingleMedia mockGetSingleMedia;
  late MediaServiceImpl mediaServiceImpl;

  setUpAll(() {
    registerFallbackValue(GetMediaPerPageParams());
  });

  setUp(() {
    mockGetMediaPerPage = MockGetMediaPerPage();
    mockGetSingleMedia = MockGetSingleMedia();
    mediaServiceImpl = MediaServiceImpl(
      getMediaPerPage: mockGetMediaPerPage,
      getSingleMedia: mockGetSingleMedia,
    );
  });

  group("getMediaPerPage -", () {
    test("should return (CurrentPageMediasEntity) when success", () async {
      //arrange
      when(
        () => mockGetMediaPerPage.call(any()),
      ).thenAnswer(
        (_) async => right(FakeCurrentPageMediasEntity()),
      );

      //act
      final result = await mediaServiceImpl.getMediaPerPage(
        GetMediaPerPageParams(),
      );
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<CurrentPageMedias>());
    });

    test("should return kind of (failure) when a failure occurs", () async {
      //arrange
      when(
        () => mockGetMediaPerPage.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result =
          await mediaServiceImpl.getMediaPerPage(GetMediaPerPageParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });

  group("getSingleMedia -", () {
    test("should return (MediaEntity) when success", () async {
      //arrange
      when(
        () => mockGetSingleMedia.call(any()),
      ).thenAnswer((_) async => right(FakeMediaEntity()));

      //act
      final result = await mediaServiceImpl.getSingleMedia(1);
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<MediaEntity>());
    });

    test("should return kind of (Failure) when fails", () async {
      //arrange
      when(
        () => mockGetSingleMedia.call(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await mediaServiceImpl.getSingleMedia(1);
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });
}
