import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

class FakeCreateOrUpdateCategoryParams extends Fake
    implements CreateOrUpdateCategoryParams {}

void main() {
  late CategoriesCubit categoriesCubit;
  const fakeCategory = CategoryEntity(
    id: 2,
    count: 3,
    description: "description",
    link: "link",
    name: "name",
    slug: "slug",
    parent: 0,
  );

  setUpAll(() {
    registerFallbackValue(FakeCreateOrUpdateCategoryParams());
  });

  setUp(() {
    categoriesCubit = MockCategoriesCubit();
    when(
      () => categoriesCubit.state,
    ).thenAnswer((_) => const CategoriesState.initial());
  });

  testWidget({
    CategoryEntity? category,
    CreateOrUpdateCategoryParamsBuilder? builder,
  }) {
    return ScreenUtilInit(
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => categoriesCubit,
          child: CreateOrEditCategoryScreen(
            category: category,
            paramsBuilderTest: builder,
          ),
        ),
      ),
    );
  }

  group("categoriesCubit -", () {
    group("listener -", () {
      testWidgets("should show failure_bottom_sheet when state is error",
          (tester) async {
        //arrange
        whenListen(
          categoriesCubit,
          Stream.fromIterable([
            CategoriesState.error(
              InternalFailure(
                  message: "message",
                  stackTrace: StackTrace.fromString("stackTraceString")),
            ),
          ]),
        );

        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("failure_bottom_sheet")), findsOneWidget);
      });
    });
    group("builder -", () {
      testWidgets("should show loadingWidget when state is loading",
          (tester) async {
        //arrange
        whenListen(
          categoriesCubit,
          Stream.fromIterable([
            const CategoriesState.loading(),
          ]),
        );
        await tester.pumpWidget(testWidget());
        await tester.pump(Durations.short1);

        //assert
        expect(find.byType(LoadingWidget), findsOneWidget);
      });

      testWidgets("should show parent_selector when state loaded",
          (tester) async {
        //arrange
        whenListen(
          categoriesCubit,
          Stream.fromIterable([
            const CategoriesState.loaded([]),
          ]),
        );
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("parent_selector")), findsOneWidget);
      });
      testWidgets("should show parent_selector when state any else loading",
          (tester) async {
        //arrange
        await tester.pumpWidget(testWidget());
        await tester.pumpAndSettle();

        //assert
        expect(find.byKey(const Key("parent_selector")), findsOneWidget);
      });
    });
  });

  group("CreateOrUpdateCategoryParamsBuilder -", () {
    testWidgets(
        "should set input values to builder when inputs onChanged invoked",
        (tester) async {
      //arrange
      final builder = CreateOrUpdateCategoryParamsBuilder();
      await tester.pumpWidget(testWidget(builder: builder));

      //verification
      final textInputFinder = find.byType(CustomFormInputField);
      expect(textInputFinder, findsNWidgets(3));

      //act
      final textInputs =
          tester.widgetList<CustomFormInputField>(textInputFinder);

      for (var input in textInputs) {
        input.onChanged!("test");
      }
      await tester
          .widget<CustomDropDownButton<CategoryEntity>>(
            find.byType(CustomDropDownButton<CategoryEntity>),
          )
          .onChanged(fakeCategory);

      //assert
      final params = builder.build();
      expect(params.name, "test");
      expect(params.description, "test");
      expect(params.slug, "test");
      expect(params.parent, fakeCategory.id);
    });
  });

  group("saveButton -", () {
    testWidgets(
        "should form be valid if name input is not empty when saveButton tapped",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());

      //verification
      expect(find.byType(Form), findsOneWidget);

      //act
      await tester.enterText(find.byKey(const Key("name_input")), "text");
      await tester.tap(find.byType(SaveButton));

      final isValid =
          (tester.widget<Form>(find.byType(Form)).key as GlobalKey<FormState>)
              .currentState
              ?.validate();

      //assert
      expect(isValid, true);
    });

    testWidgets(
        "should form be inValid if name input is empty when saveButton tapped",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget());

      //verification
      expect(find.byType(Form), findsOneWidget);

      //act
      await tester.enterText(find.byKey(const Key("name_input")), "");
      await tester.tap(find.byType(SaveButton));

      final isValid =
          (tester.widget<Form>(find.byType(Form)).key as GlobalKey<FormState>)
              .currentState
              ?.validate();

      //assert
      expect(isValid, false);
    });

    testWidgets(
        "should call createCategory of CategoriesCubit when the category property of widget is null",
        (tester) async {
      //arrange
      const category = null;
      await tester.pumpWidget(testWidget(category: category));

      //verification
      expect(find.byType(SaveButton), findsOneWidget);

      //act
      await tester.enterText(find.byKey(const Key("name_input")), "test");

      await tester.tap(find.byType(SaveButton));

      //assert
      verify(() => categoriesCubit.createCategory(any())).called(1);
    });

    testWidgets(
        "should call updateCategory of categoriesCubit when the category prop is NOT null",
        (tester) async {
      //arrange
      const category = CategoryEntity(
        id: 3,
        count: 3,
        description: "description",
        link: "link",
        name: "name",
        slug: "slug",
        parent: 0,
      );
      await tester.pumpWidget(testWidget(category: category));

      //verification

      //act
      await tester.tap(find.byType(SaveButton));

      //assert
      verify(() => categoriesCubit.updateCategory(any())).called(1);
    });
  });

  group("deleteButton -", () {
    final deleteButtonFinder = find.byKey(const Key("delete_button"));
    testWidgets("should show are_you_sure_dialog when tapped", (tester) async {
      //arrange
      await tester.pumpWidget(testWidget(category: fakeCategory));
      await tester.pumpAndSettle();

      //verification
      expect(deleteButtonFinder, findsOneWidget);

      //act
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("are_you_sure_dialog")), findsOneWidget);
    });

    testWidgets(
        "should call deleteCategory of categories cubit when confirm_button is tapped",
        (tester) async {
      //arrange
      await tester.pumpWidget(testWidget(category: fakeCategory));
      await tester.pumpAndSettle();

      //verification
      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key("are_you_sure_dialog")), findsOneWidget);
      expect(find.byKey(const Key("confirm_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("confirm_button")));

      //assert
      verify(() => categoriesCubit.deleteCategory(any())).called(1);
    });
  });
}
