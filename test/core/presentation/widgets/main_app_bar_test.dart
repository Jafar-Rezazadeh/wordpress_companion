import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/entities/profile_avatar.dart';
import 'package:wordpress_companion/core/presentation/widgets/main_app_bar.dart';
import 'package:wordpress_companion/core/router/go_router_config.dart';
import 'package:wordpress_companion/core/services/profile_service.dart';
import 'package:wordpress_companion/features/profile/profile_exports.dart';

class MockProfileServiceImpl extends Mock implements ProfileServiceImpl {}

void main() {
  late MockProfileServiceImpl mockProfileServiceImpl;
  final GetIt getIt = GetIt.instance;

  setUp(() async {
    await getIt.reset();
    mockProfileServiceImpl = MockProfileServiceImpl();
    getIt.registerLazySingleton<ProfileService>(() => mockProfileServiceImpl);
  });

  group("user interactions -", () {
    testWidgets(
        "should navigate to ProfileScreen when profile avatar is clicked",
        (tester) async {
      when(
        () => mockProfileServiceImpl.getProfileAvatar(),
      ).thenAnswer(
        (_) async => right(
          const ProfileAvatar(size24px: "", size48px: "", size96px: ""),
        ),
      );

      //arrange
      await tester.pumpWidget(
        ScreenUtilInit(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: "/",
              routes: [
                GoRoute(
                  path: "/",
                  builder: (context, state) => const Scaffold(
                    appBar: MainAppBar(),
                  ),
                  routes: [
                    GoRoute(
                      path: profileScreen,
                      name: profileScreen,
                      builder: (context, state) =>
                          Container(key: const Key("profile")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      //verification
      final avatarFinder = find.byKey(const Key("profile_avatar"));
      expect(avatarFinder, findsOneWidget);
      expect(find.byType(MainAppBar), findsOneWidget);
      expect(find.byKey(const Key("profile")), findsNothing);

      //act
      await tester.tap(avatarFinder);
      await tester.pumpAndSettle();

      //assert
      expect(find.byKey(const Key("profile")), findsOneWidget);
    });
  });
}
