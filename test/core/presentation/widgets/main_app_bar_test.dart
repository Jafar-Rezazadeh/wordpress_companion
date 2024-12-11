import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/presentation/widgets/main_app_bar.dart';

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
          child: BlocProvider(
            create: (context) => globalProfileCubit,
            child: GetMaterialApp(
              getPages: [
                GetPage(
                  name: profileScreenRoute,
                  page: () => Container(
                    key: const Key("profile"),
                  ),
                )
              ],
              home: const Scaffold(
                appBar: MainAppBar(),
              ),
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
