import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/screens/main_screen.dart';
import 'package:wordpress_companion/core/presentation/widgets/custom_drawer.dart';

class MockGlobalProfileCubit extends MockCubit<GlobalProfileState>
    implements GlobalProfileCubit {}

void main() {
  late GlobalProfileCubit globalProfileCubit;

  setUp(() {
    globalProfileCubit = MockGlobalProfileCubit();
    when(
      () => globalProfileCubit.state,
    ).thenAnswer((_) => const GlobalProfileState.initial());
  });

  group("page control -", () {
    testWidgets(
        "should show the correct page base on use interact with bottomNavBar when ",
        (tester) async {
      //arrange
      await tester.pumpWidget(_testWidget(globalProfileCubit));
      await tester.pumpAndSettle();

      //verification
      final postsPageFinder = find.byKey(const Key("posts_page"));
      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(postsPageFinder, findsOneWidget);

      final bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      final pageView = tester.widget<PageView>(find.byType(PageView));

      expect(pageView.controller?.page, 0.0);

      //act
      bottomNavBar.onTap!(1);
      await tester.pumpAndSettle();

      //assert
      expect(postsPageFinder, findsNothing);
      expect(find.byKey(const Key("categories_page")), findsOneWidget);
      expect(pageView.controller?.page, 1.0);
    });

    testWidgets(
        "should update the bottomNavBar when user changes the page using pageViewer",
        (tester) async {
      //arrange

      BottomNavigationBar bottomNavBar;
      await tester.pumpWidget(_testWidget(globalProfileCubit));
      await tester.pumpAndSettle();

      //verification
      bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      final pageView = tester.widget<PageView>(find.byType(PageView));

      expect(bottomNavBar.currentIndex, 0);

      //act
      pageView.onPageChanged!(2);

      await tester.pumpAndSettle();

      bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );

      //assert
      expect(bottomNavBar.currentIndex, 2);
    });
  });

  group("drawer -", () {
    testWidgets("should open the drawer when user tap on it", (tester) async {
      //arrange

      await tester.pumpWidget(_testWidget(globalProfileCubit));
      await tester.pumpAndSettle();

      //verification
      expect(find.byKey(const Key("drawer_button")), findsOneWidget);

      //act
      await tester.tap(find.byKey(const Key("drawer_button")));
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(CustomDrawer), findsOneWidget);
    });
  });
}

MaterialApp _testWidget(GlobalProfileCubit globalProfileCubit) {
  return MaterialApp(
    home: BlocProvider(
      create: (context) => globalProfileCubit,
      child: const MainScreen(),
    ),
  );
}
