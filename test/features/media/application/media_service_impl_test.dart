import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/application/media_service_impl.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

class MockGetMediaPerPage extends Mock implements GetMediaPerPage {}

class FakeCurrentPageMediasEntity extends Fake
    implements CurrentPageMediasEntity {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockGetMediaPerPage mockGetMediaPerPage;
  late MediaServiceImpl mediaServiceImpl;

  setUpAll(() {
    registerFallbackValue(GetMediaPerPageParams());
  });

  setUp(() {
    mockGetMediaPerPage = MockGetMediaPerPage();
    mediaServiceImpl = MediaServiceImpl(getMediaPerPage: mockGetMediaPerPage);
  });

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
    expect(rightValue, isA<CurrentPageMediasEntity>());
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
}
