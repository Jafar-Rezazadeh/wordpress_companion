import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/widgets/main_app_bar.dart';
import 'package:wordpress_companion/core/router/go_router_config.dart';

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
                  builder: (context, state) => BlocProvider(
                    create: (context) => globalProfileCubit,
                    child: const Scaffold(
                      appBar: MainAppBar(),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: profileScreenRoute,
                      name: profileScreenRoute,
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
