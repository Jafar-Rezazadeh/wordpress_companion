import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/presentation/logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/upload_card.dart';

class MockUploadMediaCubit extends MockCubit<UploadMediaState>
    implements UploadMediaCubit {}

class MockCancelToken extends Mock implements CancelToken {}

void main() {
  late UploadMediaCubit mockUploadMediaCubit;
  late CancelToken mockCancelToken;

  setUpAll(() {
    registerFallbackValue(MockCancelToken());
  });

  setUp(() {
    mockUploadMediaCubit = MockUploadMediaCubit();
    mockCancelToken = MockCancelToken();
    when(
      () => mockUploadMediaCubit.state,
    ).thenAnswer((_) => const UploadMediaState.initial());
  });

  group("uploadStateListener -", () {
    testWidgets("should set the cancelToken when state is startUploading",
        (tester) async {
      //arrange
      whenListen(
        mockUploadMediaCubit,
        Stream.fromIterable([
          UploadMediaState.startingUpload(CancelToken()),
          const UploadMediaState.uploading(0.5),
        ]),
      );

      await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
      await tester.pumpAndSettle();

      //verification
      expect(find.byKey(const Key("uploading_status")), findsOneWidget);
      expect(find.byKey(const Key("cancel_upload_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("cancel_upload_button")));

      //assert
      verify(() => mockUploadMediaCubit.cancelMediaUpload(any())).called(1);
    });

    testWidgets("should set the progressValueNotifier when state is uploading",
        (tester) async {
      //arrange
      whenListen(
        mockUploadMediaCubit,
        Stream.fromIterable([
          const UploadMediaState.uploading(0.5),
        ]),
      );
      await tester.pumpWidget(_testWidget(mockUploadMediaCubit));

      //verification
      expect(find.byType(SimpleCircularProgressBar), findsOneWidget);

      //act
      final progressValueNotifier = tester
          .firstWidget<SimpleCircularProgressBar>(
              find.byType(SimpleCircularProgressBar))
          .valueNotifier;
      await tester.pumpAndSettle();

      //assert
      expect(progressValueNotifier?.value, 0.5);
    });
  });

  group("builder -", () {
    group("remove_upload_item_button", () {
      testWidgets(
          "should hide remove_upload_item_button when state is uploading",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([
            const UploadMediaState.uploading(0.5),
          ]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(
            find.byKey(const Key("remove_upload_item_button")), findsNothing);
      });

      testWidgets(
          "should show the remove_upload_item_button when state IS NOT uploading",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([const UploadMediaState.uploaded()]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(
            find.byKey(const Key("remove_upload_item_button")), findsOneWidget);
      });

      testWidgets("should invoke the onRemove when tapped", (tester) async {
        //arrange
        bool isRemoved = false;
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([const UploadMediaState.initial()]),
        );
        await tester.pumpWidget(_testWidget(
          mockUploadMediaCubit,
          onRemove: (file) {
            isRemoved = true;
          },
        ));
        await tester.pumpAndSettle();

        //verification
        expect(
            find.byKey(const Key("remove_upload_item_button")), findsOneWidget);
        expect(isRemoved, false);

        //act
        await tester.tap(find.byKey(const Key("remove_upload_item_button")));
        await tester.pumpAndSettle();

        //assert
        expect(isRemoved, true);
      });
    });

    group("_uploadStatusInfo -", () {
      testWidgets("should show initial_status when state is initial",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([const UploadMediaState.initial()]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("initial_status")), findsOneWidget);
      });

      testWidgets("should show empty_container when state is startingUpload",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([
            UploadMediaState.startingUpload(mockCancelToken),
          ]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("empty_container")), findsOneWidget);
      });

      testWidgets("should show uploading_status when state is uploading",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([
            const UploadMediaState.uploading(0.5),
          ]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("uploading_status")), findsOneWidget);
      });

      testWidgets("should show upload_done_status when state is uploaded",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([const UploadMediaState.uploaded()]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("upload_done_status")), findsOneWidget);
      });

      testWidgets(
          "should show upload_failure_status with internal_failure_info when state is error and failure is something else",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([
            UploadMediaState.error(
              InternalFailure(
                  message: "message",
                  stackTrace: StackTrace.fromString("stackTraceString")),
            ),
          ]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("upload_failure_status")), findsOneWidget);
        expect(find.byKey(const Key("internal_failure_info")), findsOneWidget);
      });
      testWidgets(
          "should show upload_failure_status with server_failure_info when state is error and failure is ServerFailure",
          (tester) async {
        //arrange
        when(
          () => mockCancelToken.isCancelled,
        ).thenAnswer((_) => true);

        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([
            UploadMediaState.error(ServerFailure(
              message: "message",
              response: Response(
                  requestOptions: RequestOptions(cancelToken: mockCancelToken)),
              dioException: DioException(
                  requestOptions: RequestOptions(cancelToken: mockCancelToken)),
              stackTrace: StackTrace.fromString("stackTraceString"),
            )),
          ]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("upload_failure_status")), findsOneWidget);
        expect(find.byKey(const Key("server_failure_info")), findsOneWidget);
      });
    });

    group("progress -", () {
      testWidgets("should show progress_text when state is uploading",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([
            const UploadMediaState.uploading(0.5),
          ]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("progress_text")), findsOneWidget);
      });

      testWidgets("should show the upload_button when state is initial",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([const UploadMediaState.initial()]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("upload_button")), findsOneWidget);
      });

      testWidgets("should show refresh_button when state is error",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([
            UploadMediaState.error(
              InternalFailure(
                message: "message",
                stackTrace: StackTrace.fromString("stackTraceString"),
              ),
            ),
          ]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("refresh_button")), findsOneWidget);
      });

      testWidgets("should show done_icon when state is uploaded",
          (tester) async {
        //arrange
        whenListen(
          mockUploadMediaCubit,
          Stream.fromIterable([const UploadMediaState.uploaded()]),
        );
        await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("done_icon")), findsOneWidget);
      });
    });
  });

  group("uploadMediaCubit methods -", () {
    testWidgets("should invoke the uploadMedia when upload_button is tapped",
        (tester) async {
      //arrange
      whenListen(
        mockUploadMediaCubit,
        Stream.fromIterable([const UploadMediaState.initial()]),
      );

      await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
      await tester.pumpAndSettle();

      //verification
      expect(find.byKey(const Key("upload_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("upload_button")));
      await tester.pumpAndSettle();

      //assert
      verify(() => mockUploadMediaCubit.uploadMedia(any())).called(1);
    });

    testWidgets(
        "should set progressValueNotifier to 0 and invoke uploadMedia when refresh_button tapped",
        (tester) async {
      //arrange
      whenListen(
        mockUploadMediaCubit,
        Stream.fromIterable(
          [
            const UploadMediaState.uploading(0.5),
            UploadMediaState.error(
              InternalFailure(
                  message: "message",
                  stackTrace: StackTrace.fromString("stackTraceString")),
            ),
          ],
        ),
      );
      await tester.pumpWidget(_testWidget(mockUploadMediaCubit));
      await tester.pumpAndSettle();

      //verification
      expect(find.byKey(const Key("refresh_button")), findsOneWidget);
      final progressValueBefore = tester
          .widget<SimpleCircularProgressBar>(
              find.byType(SimpleCircularProgressBar))
          .valueNotifier
          ?.value;
      expect(progressValueBefore, 0.5);

      //act
      await tester.tap(find.byKey(const Key("refresh_button")));
      await tester.pumpAndSettle();

      //assert
      verify(() => mockUploadMediaCubit.uploadMedia(any())).called(1);
      final progressValueAfter = tester
          .widget<SimpleCircularProgressBar>(
              find.byType(SimpleCircularProgressBar))
          .valueNotifier
          ?.value;
      expect(progressValueAfter, 0);
    });
  });
}

MaterialApp _testWidget(UploadMediaCubit mockUploadMediaCubit,
    {Function(PlatformFile file)? onRemove,
    Function(bool value)? isUploading}) {
  return MaterialApp(
    home: BlocProvider(
      create: (context) => mockUploadMediaCubit,
      child: UploadCard(
        file: PlatformFile(name: "test", size: 1566320),
        onRemove: onRemove ?? (file) {},
        isUploading: isUploading ?? (value) {},
      ),
    ),
  );
}
