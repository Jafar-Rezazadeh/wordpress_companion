import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/screens/main_screen.dart';
import 'package:wordpress_companion/core/services/profile_service.dart';

import 'package:wordpress_companion/features/login/login_exports.dart';
import 'package:wordpress_companion/features/profile/presentation/screens/profile_screen.dart';

import '../../features/profile/profile_exports.dart';
import '../../features/site_settings/presentation/screens/site_settings_screen.dart';

const String loginScreenRoute = "/login";
const String mainScreenRoute = "/main";
const String profileScreenRoute = "profile";
const String siteSettingsScreenRoute = "siteSettings";

final GetIt getIt = GetIt.instance;

final goRouter = GoRouter(
  // FIXME: change it to login when testing ends
  initialLocation: loginScreenRoute,
  routes: [
    GoRoute(
      name: loginScreenRoute,
      path: loginScreenRoute,
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
          name: mainScreenRoute,
          path: mainScreenRoute,
          builder: (context, state) => const MainScreen(),
          routes: [
            GoRoute(
              name: profileScreenRoute,
              path: profileScreenRoute,
              builder: (context, state) => BlocProvider(
                create: (context) => getIt<ProfileCubit>(),
                child: const ProfileScreen(),
              ),
            ),
            GoRoute(
              name: siteSettingsScreenRoute,
              path: siteSettingsScreenRoute,
              builder: (context, state) => const SiteSettingsScreen(),
            )
          ],
        ),
      ],
    ),
  ],
);
