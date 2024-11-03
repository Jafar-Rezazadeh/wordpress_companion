import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/contracts/use_case.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';

class MockUploadMedia extends Mock implements UploadMedia {}

class MockCancelMediaUpload extends Mock implements CancelMediaUpload {}

class MockCancelToken extends Mock implements CancelToken {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockUploadMedia mockUploadMedia;
  late MockCancelMediaUpload mockCancelMediaUpload;
  late MockCancelToken mockCancelToken;
  late UploadMediaCubit uploadMediaCubit;

  setUp(() {
    mockUploadMedia = MockUploadMedia();
    mockCancelMediaUpload = MockCancelMediaUpload();

    mockCancelToken = MockCancelToken();
    uploadMediaCubit = UploadMediaCubit(
      uploadMedia: mockUploadMedia,
      cancelMediaUpload: mockCancelMediaUpload,
    );
  });
  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(MockCancelToken());
  });

  group("UploadMediaCubit -", () {
    blocTest<UploadMediaCubit, UploadMediaState>(
      'emits [startingUpload, uploading, uploaded] when successfully uploaded',
      setUp: () {
        final streamController = StreamController<double>();
        streamController.add(0.5);
        streamController.add(1.0);
        streamController.close();

        when(
          () => mockUploadMedia.call(any()),
        ).thenAnswer(
          (_) async => right(
            (cancelToken: mockCancelToken, stream: streamController.stream),
          ),
        );
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.uploadMedia("path"),
      expect: () => [
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(startingUpload: (_) => true),
          'is startingUpload state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(uploading: (progress) => progress == 0),
          'is uploading(0) state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(uploading: (progress) => progress == 0.5),
          'is uploading(0.5) state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(uploading: (progress) => progress == 1.0),
          'is uploading(1.0) state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(uploaded: () => true),
          'is uploaded state',
          true,
        ),
      ],
    );
    blocTest<UploadMediaCubit, UploadMediaState>(
      'emits [startingUpload,uploading, error] when an error occurred on listen to stream',
      setUp: () {
        final streamController = StreamController<double>();
        streamController.add(0.5);
        streamController.addError(Exception());
        streamController.close();

        when(
          () => mockUploadMedia.call(any()),
        ).thenAnswer(
          (_) async => right(
            (cancelToken: mockCancelToken, stream: streamController.stream),
          ),
        );
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.uploadMedia("pathToFile"),
      expect: () => [
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(startingUpload: (_) => true),
          'is statingUpload state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(uploading: (progress) => progress == 0),
          'is uploading(0) state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(uploading: (progress) => progress == 0.5),
          'is uploading(0.5) state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );

    blocTest<UploadMediaCubit, UploadMediaState>(
      'emits [error] when a failure occurred',
      setUp: () {
        when(
          () => mockUploadMedia.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.uploadMedia("pathToFile"),
      expect: () => [
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );
  });

  group("cancelMediaUpload -", () {
    blocTest<UploadMediaCubit, UploadMediaState>(
      'emits [] when success to cancel',
      setUp: () {
        when(
          () => mockCancelMediaUpload.call(any()),
        ).thenAnswer((_) async => right(null));
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.cancelMediaUpload(mockCancelToken),
      expect: () => [],
      verify: (_) => verify(() => mockCancelMediaUpload.call(any())).called(1),
    );

    blocTest<UploadMediaCubit, UploadMediaState>(
      'emits [error] when a failure occurred',
      setUp: () {
        when(
          () => mockCancelMediaUpload.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.cancelMediaUpload(mockCancelToken),
      expect: () => [
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
      verify: (_) => verify(() => mockCancelMediaUpload.call(any())).called(1),
    );
  });
}
