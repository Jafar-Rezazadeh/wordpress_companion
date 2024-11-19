import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/categories/application/widgets/category_selector_widget.dart';
import 'package:wordpress_companion/features/categories/domain/entities/category_entity.dart';
import 'package:wordpress_companion/features/categories/presentation/logic_holders/categories_cubit/categories_cubit.dart';

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

class FakeCategoryEntity extends Fake implements CategoryEntity {
  @override
  int get id => 20;

  @override
  String get name => "test";

  @override
  int get parent => 0;
}

class FakeChildCategoryEntity extends Fake implements CategoryEntity {
  @override
  int get id => 26;

  @override
  String get name => "test";

  @override
  int get parent => 20;
}

void main() {
  late CategoriesCubit categoriesCubit;

  setUp(() {
    categoriesCubit = MockCategoriesCubit();
    when(
      () => categoriesCubit.state,
    ).thenAnswer((_) => const CategoriesState.initial());
  });

  testWidget({Function(List<CategoryEntity> value)? onSelect}) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => categoriesCubit,
        child: Material(
          child: CategorySelectorWidget(
            onSelect: onSelect ?? (value) {},
          ),
        ),
      ),
    );
  }

  group("CategoriesCubit -", () {
    testWidgets("should show LoadingWidget when state is loading",
        (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          const CategoriesState.loading(),
        ]),
      );

      await tester.pumpWidget(testWidget());
      await tester.pump();

      //assert
      expect(find.byKey(const Key("categories_checkBoxes")), findsNothing);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets("should show categories_checkBoxes when state is loaded",
        (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          CategoriesState.loaded([
            FakeCategoryEntity(),
            FakeChildCategoryEntity(),
          ]),
        ]),
      );

      await tester.pumpWidget(testWidget());
      await tester.pump();

      //assert
      expect(find.byType(LoadingWidget), findsNothing);

      expect(find.byKey(const Key("categories_checkBoxes")), findsOneWidget);
      expect(find.byKey(const Key("category_node")), findsWidgets);
      expect(find.byKey(const Key("category_child_node")), findsOneWidget);
    });

    testWidgets("should show needRefresh_text when state is needRefresh",
        (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          const CategoriesState.needRefresh(),
        ]),
      );

      await tester.pumpWidget(testWidget());
      await tester.pump();

      //assert
      expect(find.byType(LoadingWidget), findsNothing);
      expect(find.byKey(const Key("categories_checkBoxes")), findsNothing);

      expect(find.byKey(const Key("needRefresh_text")), findsOneWidget);
    });

    testWidgets("should show failure_text when state is error", (tester) async {
      //arrange
      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          CategoriesState.error(
            InternalFailure(
              message: "message",
              stackTrace: StackTrace.fromString("test"),
            ),
          ),
        ]),
      );

      await tester.pumpWidget(testWidget());
      await tester.pump();

      //assert
      expect(find.byType(LoadingWidget), findsNothing);
      expect(find.byKey(const Key("categories_checkBoxes")), findsNothing);
      expect(find.byKey(const Key("needRefresh_text")), findsNothing);

      expect(find.byKey(const Key("failure_text")), findsOneWidget);
    });
  });

  group("onSelect -", () {
    testWidgets("should return selected Categories when onSelect invoked",
        (tester) async {
      //arrange
      List<CategoryEntity> category = [];

      whenListen(
        categoriesCubit,
        Stream.fromIterable([
          CategoriesState.loaded([
            FakeCategoryEntity(),
            FakeChildCategoryEntity(),
          ]),
        ]),
      );

      await tester.pumpWidget(
        testWidget(onSelect: (value) => category = value),
      );
      await tester.pumpAndSettle();

      //verification
      expect(find.byType(CheckboxListTile), findsWidgets);

      //act
      await tester.tap(find.byType(CheckboxListTile).first);
      await tester.pumpAndSettle();

      //assert
      expect(category.length, greaterThan(0));
    });
  });
}
