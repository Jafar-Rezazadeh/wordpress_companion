import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/presentation/widgets/main_app_bar.dart';
import 'package:wordpress_companion/core/router/go_router_config.dart';
import 'package:wordpress_companion/features/profile/presentation/screens/profile_screen.dart';

void main() {
  group("user interactions -", () {
    testWidgets(
        "should navigate to ProfileScreen when profile avatar is clicked",
        (tester) async {
      //arrange
      await tester.pumpWidget(
        ScreenUtilInit(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: "/",
              routes: [
                GoRoute(
                  path: "/",
                  builder: (context, state) => Scaffold(
                    appBar: MainAppBar(
                      imageProviderTest: FileImage(File('')),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: profileScreen,
                      name: profileScreen,
                      builder: (context, state) => const ProfileScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      //verification
      final avatarFinder = find.byKey(const Key("profile_avatar"));
      expect(avatarFinder, findsOneWidget);
      expect(find.byType(MainAppBar), findsOneWidget);
      expect(find.byType(ProfileScreen), findsNothing);

      //act
      await tester.tap(avatarFinder);
      await tester.pumpAndSettle();

      //assert
      expect(find.byType(ProfileScreen), findsOneWidget);
    });
  });
}
