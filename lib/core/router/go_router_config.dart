import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/presentation/screens/main_screen.dart';

import 'package:wordpress_companion/features/login/login_exports.dart';
import 'package:wordpress_companion/features/profile/presentation/screens/profile_screen.dart';

import '../../features/profile/profile_exports.dart';

const String loginScreen = "/login";
const String mainScreen = "/main";
const String profileScreen = "profile";
// const String postScreen = "/post";
// const String postsScreen = "/posts";
// const String settingsScreen = "/settings";

final GetIt getIt = GetIt.instance;

final goRouter = GoRouter(
  // FIXME: change it to login when testing ends
  initialLocation: loginScreen,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthenticationCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<LoginCredentialsCubit>(),
          ),
        ],
        child: child,
      ),
      routes: [
        GoRoute(
          name: loginScreen,
          path: loginScreen,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: mainScreen,
          path: mainScreen,
          builder: (context, state) => const MainScreen(),
          routes: [
            GoRoute(
              name: profileScreen,
              path: profileScreen,
              builder: (context, state) => BlocProvider(
                create: (context) => getIt<ProfileCubit>(),
                child: const ProfileScreen(),
              ),
            ),
          ],
        ),
      ],
    )
  ],
);
