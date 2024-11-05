import 'package:bloc_test/bloc_test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/upload_card.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/uploader.dart';

class MockUploadMediaCubit extends MockCubit<UploadMediaState>
    implements UploadMediaCubit {}

void main() {
  late UploadMediaCubit uploadMediaCubit;
  GetIt getIt = GetIt.instance;

  setUp(() {
    uploadMediaCubit = MockUploadMediaCubit();
    getIt.registerFactory<UploadMediaCubit>(() => uploadMediaCubit);
    when(
      () => uploadMediaCubit.state,
    ).thenAnswer((_) => const UploadMediaState.initial());
  });
  tearDown(() {
    getIt.reset();
  });

  testWidgets("should invoke the onRemove when it invoke by UploadCard",
      (tester) async {
    //arrange
    bool isInvoked = false;
    void onRemove() {
      isInvoked = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Uploader(
          file: PlatformFile(name: "test", size: 156920),
          onRemove: (_) => onRemove(),
        ),
      ),
    );

    //verification
    expect(find.byType(Uploader), findsOneWidget);
    expect(find.byType(UploadCard), findsOneWidget);

    //act
    final uploadCard = tester.widget<UploadCard>(find.byType(UploadCard));
    uploadCard.onRemove(uploadCard.file);

    //assert
    expect(isInvoked, true);
  });

  testWidgets("should set the uploadingNotifier when isUploading invoked",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Uploader(
          file: PlatformFile(name: "test", size: 156920),
          onRemove: (_) {},
        ),
      ),
    );

    //verification
    expect(find.byType(Uploader), findsOneWidget);
    final uploader = tester.widget<Uploader>(find.byType(Uploader));
    expect(uploader.uploadingNotifier.value, false);
    expect(find.byType(UploadCard), findsOneWidget);

    //act
    final uploadCard = tester.widget<UploadCard>(find.byType(UploadCard));
    uploadCard.isUploading(true);

    //assert
    final uploaderNotifier = tester
        .widget<Uploader>(
          find.byType(Uploader),
        )
        .uploadingNotifier;
    expect(uploaderNotifier.value, true);
  });
}
