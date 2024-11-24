import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

class FakeFailure extends Fake implements Failure {}

class FakeMediaEntity extends Fake implements MediaEntity {}

void main() {
  late MockMediaRepository mockMediaRepository;
  late UploadMedia uploadMedia;
  final UploadMediaResult uploadMediaResult =
      (cancelToken: CancelToken(), stream: const Stream<double>.empty());
  setUp(() {
    mockMediaRepository = MockMediaRepository();
    uploadMedia = UploadMedia(mediaRepository: mockMediaRepository);
  });

  test(
      "should return the progress of upload as (UploadMediaResult) when uploading",
      () async {
    //arrange
    when(
      () => mockMediaRepository.uploadMediaFile(any()),
    ).thenAnswer((_) async => right(uploadMediaResult));

    //act
    final result = await uploadMedia.call("path");
    final rightValue = result.fold((l) => null, (r) => r);

    //assert
    expect(result.isRight(), true);
    expect(rightValue, isA<UploadMediaResult>());
  });

  test("should return kind of (Failure) when fails to upload", () async {
    //arrange
    when(
      () => mockMediaRepository.uploadMediaFile(any()),
    ).thenAnswer((_) async => left(FakeFailure()));

    //act
    final result = await uploadMedia.call("path");
    final leftValue = result.fold((l) => l, (r) => null);

    //assert
    expect(result.isLeft(), true);
    expect(leftValue, isA<Failure>());
  });
}
