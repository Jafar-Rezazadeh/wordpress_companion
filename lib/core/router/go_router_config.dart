import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/screens/main_screen.dart';
import 'package:wordpress_companion/core/services/profile_service.dart';

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
    GoRoute(
      name: loginScreen,
      path: loginScreen,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthenticationCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<LoginCredentialsCubit>(),
          ),
        ],
        child: const LoginScreen(),
      ),
    ),
    ShellRoute(
      builder: (context, state, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GlobalProfileCubit(
              profileService: getIt<ProfileService>(),
            ),
          ),
        ],
        child: child,
      ),
      routes: [
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
    ),
  ],
);
