import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/entities/profile_avatar.dart';
import 'package:wordpress_companion/core/presentation/screens/main_screen.dart';
import 'package:wordpress_companion/core/services/profile_service.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileServiceImpl extends Mock implements ProfileServiceImpl {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockProfileServiceImpl mockProfileServiceImpl;
  final GetIt getIt = GetIt.instance;

  setUp(() async {
    await getIt.reset();
    mockProfileServiceImpl = MockProfileServiceImpl();
    getIt.registerLazySingleton<ProfileService>(() => mockProfileServiceImpl);
  });

  group("page control -", () {
    testWidgets(
        "should show the correct page base on use interact with bottomNavBar when ",
        (tester) async {
      //arrange
      when(
        () => mockProfileServiceImpl.getProfileAvatar(),
      ).thenAnswer(
        (_) async => right(
          const ProfileAvatar(size24px: "", size48px: "", size96px: ""),
        ),
      );
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));
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
      when(
        () => mockProfileServiceImpl.getProfileAvatar(),
      ).thenAnswer(
        (_) async => right(
            const ProfileAvatar(size24px: "", size48px: "", size96px: "")),
      );
      BottomNavigationBar bottomNavBar;
      await tester.pumpWidget(const MaterialApp(home: MainScreen()));
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
}
