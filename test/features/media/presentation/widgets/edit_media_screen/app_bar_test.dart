import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/edit_media_screen/app_bar.dart';

class FakeMediaEntity extends Fake implements MediaEntity {
  @override
  int get id => 2;

  @override
  String get title => "title";

  @override
  String get sourceUrl => "/image.jpeg";
}

class MockDownloader extends Mock implements Downloader {}

class MockMediaCubit extends MockCubit<MediaState> implements MediaCubit {}

void main() {
  late MockDownloader mockDownloader;
  late MediaCubit mediaCubit;

  setUp(() {
    mockDownloader = MockDownloader();
    mediaCubit = MockMediaCubit();
    when(() => mediaCubit.state).thenAnswer((_) => const MediaState.initial());
  });

  testWidgets("should call the downloader when download button in tapped",
      (tester) async {
    //arrange
    when(
      () => mockDownloader.downloadFile(
          url: any(named: "url"), fileFullName: any(named: "fileFullName")),
    ).thenAnswer((_) async => "taskId1");

    await tester.pumpWidget(_makeTestWidget(mediaCubit, mockDownloader));

    // verification
    expect(find.byKey(const Key("download_button")), findsOneWidget);

    //act
    await tester.tap(find.byKey(const Key("download_button")));
    await tester.pumpAndSettle();

    //assert
    verify(
      () => mockDownloader.downloadFile(
        url: any(named: "url"),
        fileFullName: any(named: "fileFullName"),
      ),
    ).called(1);
  });
}

BlocProvider<MediaCubit> _makeTestWidget(
    MediaCubit mediaCubit, MockDownloader mockDownloader) {
  return BlocProvider(
    create: (context) => mediaCubit,
    child: MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: EditMediaScreenAppBar(
            context: context,
            onSubmit: () {},
            mediaEntity: FakeMediaEntity(),
            downloader: mockDownloader,
          ).build(),
        );
      }),
    ),
  );
}
