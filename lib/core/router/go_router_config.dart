import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/site_settings/presentation/state_Management/site_settings_cubit/site_settings_cubit.dart';
import '../presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import '../presentation/screens/main_screen.dart';
import '../services/profile_service.dart';

import '../../features/login/login_exports.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

import '../../features/profile/profile_exports.dart';
import '../../features/site_settings/presentation/screens/site_settings_screen.dart';

const String loginScreenRoute = "/login";
const String mainScreenRoute = "/main";
const String profileScreenRoute = "profile";
const String siteSettingsScreenRoute = "siteSettings";

final GetIt getIt = GetIt.instance;

final goRouter = GoRouter(
  initialLocation: loginScreenRoute,
  routes: [
    _loginScreenRoute(),
    _mainScreenRoute(),
  ],
);

GoRoute _loginScreenRoute() {
  return GoRoute(
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
  );
}

ShellRoute _mainScreenRoute() {
  return ShellRoute(
    builder: _mainScreenProvider,
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
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<SiteSettingsCubit>(),
              child: SiteSettingsScreen(),
            ),
          )
        ],
      ),
    ],
  );
}

Widget _mainScreenProvider(context, state, child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            GlobalProfileCubit(profileService: getIt<ProfileService>()),
      ),
      BlocProvider(
        create: (context) => getIt<MediaCubit>(),
      )
    ],
    child: child,
  );
}
