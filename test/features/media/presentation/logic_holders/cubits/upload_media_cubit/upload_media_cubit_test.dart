import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/errors/failures.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';

class MockUploadMedia extends Mock implements UploadMedia {}

class FakeFailure extends Fake implements Failure {}

void main() {
  late MockUploadMedia mockUploadMedia;
  late UploadMediaCubit uploadMediaCubit;

  setUp(() {
    mockUploadMedia = MockUploadMedia();
    uploadMediaCubit = UploadMediaCubit(uploadMedia: mockUploadMedia);
  });

  group("UploadMediaCubit -", () {
    blocTest<UploadMediaCubit, UploadMediaState>(
      'emits [uploading, uploaded] when successfully uploaded',
      setUp: () {
        final streamController = StreamController<double>();
        streamController.add(0.5);
        streamController.add(1.0);
        streamController.close();

        when(
          () => mockUploadMedia.call(any()),
        ).thenAnswer(
          (_) async => right(streamController.stream),
        );
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.uploadMedia("path"),
      expect: () => [
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
      'emits [uploading, error] when an error occurred on listen to stream',
      setUp: () {
        final streamController = StreamController<double>();
        streamController.add(0.5);
        streamController.addError(Exception());
        streamController.close();

        when(
          () => mockUploadMedia.call(any()),
        ).thenAnswer(
          (_) async => right(streamController.stream),
        );
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.uploadMedia("pathToFile"),
      expect: () => [
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
      'emits [uploading , error] when a failure occurred',
      setUp: () {
        when(
          () => mockUploadMedia.call(any()),
        ).thenAnswer((_) async => left(FakeFailure()));
      },
      build: () => uploadMediaCubit,
      act: (cubit) => cubit.uploadMedia("pathToFile"),
      expect: () => [
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(uploading: (_) => true),
          'is uploading state',
          true,
        ),
        isA<UploadMediaState>().having(
          (state) => state.whenOrNull(error: (_) => true),
          'is error state',
          true,
        ),
      ],
    );
  });
}
