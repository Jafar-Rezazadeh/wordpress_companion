import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

class FakeFailure extends Fake implements Failure {}

class FakeCurrentPageMediasEntity extends Fake implements CurrentPageMedias {}

void main() {
  late MockMediaRepository mockMediaRepository;
  late GetMediaPerPage getAllMedia;

  setUpAll(() {
    registerFallbackValue(GetMediaPerPageParams());
  });

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    getAllMedia = GetMediaPerPage(mediaRepository: mockMediaRepository);
  });

  group("params -", () {
    group("when create", () {
      test("should params has expected default value on create ", () {
        //arrange
        final params = GetMediaPerPageParams();

        //assert
        expect(params.page, 1);
        expect(params.perPage, 10);
        expect(params.search, null);
        expect(params.after, null);
        expect(params.before, null);
        expect(params.type, null);
      });
      test("should throw (AssertionError) when page is less than 1 ", () {
        //assert
        expect(() => GetMediaPerPageParams(page: 0), throwsAssertionError);
        expect(() => GetMediaPerPageParams(page: -2), throwsAssertionError);
      });
      test("should throw (AssertionError) when perPage is less than 10 ", () {
        //assert
        expect(() => GetMediaPerPageParams(perPage: 9), throwsAssertionError);
      });
    });
    group("copyWith -", () {
      test("should return (GetMediaPerPageParams) ", () {
        //arrange
        final params = GetMediaPerPageParams();

        //act
        final result = params.copyWith();

        //assert
        expect(result, isA<GetMediaPerPageParams>());
      });

      test(
          "should copy the properties and return (GetMediaPerPageParams) with given new properties",
          () {
        //arrange
        final params = GetMediaPerPageParams();

        //act
        final pageChangedParams = params.copyWith(page: 2);

        //assert
        expect(pageChangedParams.page, 2);
        expect(pageChangedParams.perPage, 10);
        expect(pageChangedParams.search, null);
        expect(pageChangedParams.after, null);
        expect(pageChangedParams.before, null);
        expect(pageChangedParams.type, null);
      });
    });
  });

  group("useCase -", () {
    test("should return (CurrentPageMediasEntity) when success", () async {
      //arrange
      when(
        () => mockMediaRepository.getMediaPerPage(any()),
      ).thenAnswer((_) async => right(FakeCurrentPageMediasEntity()));

      //act
      final result = await getAllMedia.call(GetMediaPerPageParams());
      final rightValue = result.fold((l) => null, (r) => r);

      //assert
      expect(result.isRight(), true);
      expect(rightValue, isA<CurrentPageMedias>());
    });

    test("should return kind of (Failure) when fails", () async {
      //arrange
      when(
        () => mockMediaRepository.getMediaPerPage(any()),
      ).thenAnswer((_) async => left(FakeFailure()));

      //act
      final result = await getAllMedia.call(GetMediaPerPageParams());
      final leftValue = result.fold((l) => l, (r) => null);

      //assert
      expect(result.isLeft(), true);
      expect(leftValue, isA<Failure>());
    });
  });
}
