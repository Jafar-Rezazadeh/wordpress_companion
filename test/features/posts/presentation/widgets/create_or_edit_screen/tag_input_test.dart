import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import 'package:wordpress_companion/features/tags/tags_exports.dart';

class MockTagsCubit extends MockCubit<TagsState> implements TagsCubit {}

class FakeTagEntity extends Fake implements TagEntity {
  @override
  int get id => 5;

  @override
  String get name => "test";
}

void main() {
  late TagsCubit tagsCubit;

  setUp(() {
    tagsCubit = MockTagsCubit();
    when(() => tagsCubit.state).thenAnswer((_) => const TagsState.initial());
  });
  Widget testWidget({Function(List<TagEntity> tags)? onChanged}) {
    return ScreenUtilInit(
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => tagsCubit,
          child: Material(
            child: TagInputWidget(
              initialTags: const [],
              onChanged: onChanged ?? (value) {},
            ),
          ),
        ),
      ),
    );
  }

  group("initState -", () {
    testWidgets("should call tagsCubit.getTagsByIds when widget initialized",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());

      //assert
      verify(() => tagsCubit.getTagsByIds(any())).called(1);
    });
  });

  group("add_tag_button -", () {
    testWidgets(
        "should call onChange when tapped and SearchField<TagEntity> is not Null",
        (tester) async {
      //arrange
      bool isInvoked = false;
      onChanged(List<TagEntity> tag) {
        isInvoked = true;
      }

      whenListen(
        tagsCubit,
        Stream.fromIterable([
          TagsState.created(FakeTagEntity()),
        ]),
      );

      await tester.pumpWidget(testWidget(onChanged: onChanged));
      await tester.pumpAndSettle();

      //verification
      final searchFieldFinder = find.byType(SearchField<TagEntity>);
      final addButtonFinder = find.byKey(const Key("add_tag_button"));
      expect(searchFieldFinder, findsOneWidget);
      expect(addButtonFinder, findsOneWidget);

      //act
      await tester.enterText(searchFieldFinder, "text");

      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();
      //assert
      expect(isInvoked, true);
    });

    testWidgets("should call createTag when value is not in searchResult",
        (tester) async {
      //arrange
      List<TagEntity> tags = [];

      whenListen(
        tagsCubit,
        Stream.fromIterable([
          TagsState.created(FakeTagEntity()),
        ]),
        initialState: const TagsState.searchResult([]),
      );
      await tester.pumpWidget(
        testWidget(
          onChanged: (listOfTags) => tags = listOfTags,
        ),
      );

      //act
      await tester.enterText(find.byType(SearchField<TagEntity>), "text");
      await tester.tap(find.byKey(const Key("add_tag_button")));
      await tester.pumpAndSettle();

      //assert
      verify(() => tagsCubit.createTag(any())).called(1);
      expect(tags, isNotEmpty);
    });

    testWidgets("should Not Call CreateTag when tag is already in searchResult",
        (tester) async {
      //arrange
      whenListen(
        tagsCubit,
        Stream.fromIterable([
          TagsState.searchResult([FakeTagEntity()]),
        ]),
      );
      List<TagEntity> tags = [];
      await tester.pumpWidget(
        testWidget(
          onChanged: (tagsOnChanged) => tags = tagsOnChanged,
        ),
      );

      //act
      await tester.enterText(
          find.byType(SearchField<TagEntity>), FakeTagEntity().name);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("add_tag_button")));
      await tester.pumpAndSettle();

      //assert
      verifyNever(() => tagsCubit.createTag(any()));
      expect(tags, isNotEmpty);
    });
  });

  group("tagsCubit -", () {
    group("_tagsStateListener -", () {
      testWidgets("should add tags to assigned tag when state is getTagsByIds",
          (tester) async {
        //arrange
        whenListen(
          tagsCubit,
          Stream.fromIterable([
            TagsState.tagsByIds([FakeTagEntity()])
          ]),
        );

        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //verification
        final tagChipFinder = find.byType(Chip);

        //assert
        expect(tagChipFinder, findsOneWidget);
      });

      testWidgets("should show failure_bottom_sheet when state is error",
          (tester) async {
        //arrange
        whenListen(
          tagsCubit,
          Stream.fromIterable([
            TagsState.error(
              InternalFailure(
                  message: "message",
                  stackTrace: StackTrace.fromString("stackTraceString")),
            )
          ]),
        );
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("failure_bottom_sheet")), findsOneWidget);
      });
    });
  });

  group("searchField -", () {
    testWidgets("should add tag when suggestion is tapped", (tester) async {
      //arrange

      await tester.pumpWidget(testWidget());
      await tester.pumpAndSettle();
      final searchFieldFinder = find.byType(SearchField<TagEntity>);

      //verification
      expect(find.byType(Chip), findsNothing);
      expect(searchFieldFinder, findsOneWidget);

      //act
      final searchFieldItem = SearchFieldListItem<TagEntity>(
        "test",
        child: Container(),
        item: FakeTagEntity(),
      );
      await tester
          .widget<SearchField<TagEntity>>(searchFieldFinder)
          .onSuggestionTap!(searchFieldItem);

      await tester.pumpAndSettle();

      //assert
      expect(find.byType(Chip), findsOneWidget);
    });

    testWidgets(
        "should remove tag from assignedTags when onDelete TagChip invoked",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());
      await tester.pumpAndSettle();

      //verification
      final searchFieldFinder = find.byType(SearchField<TagEntity>);
      final searchFieldItem = SearchFieldListItem<TagEntity>(
        "test",
        child: Container(),
        item: FakeTagEntity(),
      );
      await tester
          .widget<SearchField<TagEntity>>(searchFieldFinder)
          .onSuggestionTap!(searchFieldItem);

      await tester.pumpAndSettle();
      expect(find.byType(Chip), findsOneWidget);

      //act
      tester.widget<Chip>(find.byType(Chip)).onDeleted!();
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(Chip), findsNothing);
    });
  });
}
