import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/features/media/presentation/logic_holders/cubits/upload_media_cubit/upload_media_cubit.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/upload_card.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/upload_file_dialog.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/upload_media_dialog/uploader.dart';

class MockFilePickerPlatform extends FilePicker {
  @override
  Future<FilePickerResult?> pickFiles(
      {String? dialogTitle,
      String? initialDirectory,
      FileType type = FileType.any,
      List<String>? allowedExtensions,
      Function(FilePickerStatus p1)? onFileLoading,
      bool allowCompression = true,
      int compressionQuality = 30,
      bool allowMultiple = false,
      bool withData = false,
      bool withReadStream = false,
      bool lockParentWindow = false,
      bool readSequential = false}) async {
    return FilePickerResult(
      [
        PlatformFile(name: "test", size: Random.secure().nextInt(1000000)),
      ],
    );
  }
}

class MockUploadMediaCubit extends MockCubit<UploadMediaState>
    implements UploadMediaCubit {}

void main() {
  late MockFilePickerPlatform mockFilePickerPlatform;
  late MockUploadMediaCubit mockUploadMediaCubit;
  GetIt getIt = GetIt.instance;

  setUp(() {
    mockFilePickerPlatform = MockFilePickerPlatform();
    FilePicker.platform = mockFilePickerPlatform;

    mockUploadMediaCubit = MockUploadMediaCubit();
    getIt.registerFactory<UploadMediaCubit>(() => mockUploadMediaCubit);
    when(
      () => mockUploadMediaCubit.state,
    ).thenAnswer((_) => const UploadMediaState.initial());
  });

  tearDown(
    () {
      getIt.reset();
    },
  );

  group("listOfUploader -", () {
    testWidgets(
        "should add a new Uploader when user select a file via pick_file_button",
        (tester) async {
      //arrange

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => UploadFileDialog(dialogContext: context),
          ),
        ),
      );

      await tester.pumpAndSettle();

      //verification
      expect(find.byKey(const Key("pick_file_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("pick_file_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(UploadCard), findsOneWidget);
    });

    testWidgets("should remove the uploader when uploader onRemove is invoked",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => UploadFileDialog(dialogContext: context),
          ),
        ),
      );

      await tester.pumpAndSettle();

      //verification
      expect(find.byKey(const Key("pick_file_button")), findsOneWidget);
      await tester.tap(find.byKey(const Key("pick_file_button")));
      await tester.pumpAndSettle();

      expect(find.byType(Uploader), findsOneWidget);

      //act
      final uploader = tester.widget<Uploader>(find.byType(Uploader).first);
      uploader.onRemove(uploader);
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(Uploader), findsNothing);
    });
  });

  group("back_button -", () {
    testWidgets(
        "should not pop and show a uploading_alert if even one of the uploader is uploading ",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidgetPop());
      await tester.pumpAndSettle();

      await tester.tap(find.text("openDialog"));
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(UploadFileDialog), findsOneWidget);
      await _makeTreeUploader(tester);

      //act
      final listOfUploader = tester.widgetList<Uploader>(find.byType(Uploader));
      listOfUploader.elementAt(0).uploadingNotifier.value = false;
      listOfUploader.elementAt(1).uploadingNotifier.value = true;
      listOfUploader.elementAt(2).uploadingNotifier.value = false;
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("back_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(UploadFileDialog), findsOneWidget);
      expect(find.byKey(const Key("uploading_alert")), findsOneWidget);
    });

    testWidgets(
        "should pop the dialog and not shown the uploading_alert when uploader are not uploading",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidgetPop());
      await tester.pumpAndSettle();

      await tester.tap(find.text("openDialog"));
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(UploadFileDialog), findsOneWidget);
      await _makeTreeUploader(tester);

      //act
      final listOfUploader = tester.widgetList<Uploader>(find.byType(Uploader));
      listOfUploader.elementAt(0).uploadingNotifier.value = false;
      listOfUploader.elementAt(1).uploadingNotifier.value = false;
      listOfUploader.elementAt(2).uploadingNotifier.value = false;
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("back_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(UploadFileDialog), findsNothing);
      expect(find.byKey(const Key("uploading_alert")), findsNothing);
    });
  });
}

Future<void> _makeTreeUploader(WidgetTester tester) async {
  await _pickTreeFiles(tester);
  await tester.pumpAndSettle();
  expect(find.byType(Uploader), findsExactly(3));
}

Future<void> _pickTreeFiles(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key("pick_file_button")));
  await tester.tap(find.byKey(const Key("pick_file_button")));
  await tester.tap(find.byKey(const Key("pick_file_button")));
}

MaterialApp _testWidgetPop() {
  return MaterialApp(
    home: Scaffold(
      body: Builder(builder: (context) {
        return ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) =>
                  UploadFileDialog(dialogContext: dialogContext),
            );
          },
          child: const Text("openDialog"),
        );
      }),
    ),
  );
}
