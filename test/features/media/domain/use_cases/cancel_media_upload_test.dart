import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

class MockCancelToken extends Mock implements CancelToken {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockMediaRepository mockMediaRepository;
  late MockCancelToken mockCancelToken;
  late CancelMediaUpload cancelMediaUpload;

  setUpAll(() {
    registerFallbackValue(MockCancelToken());
  });

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    mockCancelToken = MockCancelToken();
    cancelMediaUpload = CancelMediaUpload(mediaRepository: mockMediaRepository);
  });

  test("should return (void) as right Value", () async {
    //arrange
    when(
      () => mockMediaRepository.cancelMediaUpload(any()),
    ).thenAnswer((_) async => right(null));

    //act
    final result = await cancelMediaUpload.call(mockCancelToken);

    //assert
    expect(result.isRight(), true);
  });

  test("should return kind of (Failure) when fails", () async {
    //arrange
    when(
      () => mockMediaRepository.cancelMediaUpload(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await cancelMediaUpload.call(mockCancelToken);
    final rightValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(rightValue, isA<Failure>());
  });
}
