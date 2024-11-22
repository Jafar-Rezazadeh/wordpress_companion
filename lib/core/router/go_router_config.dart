import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import '../../features/site_settings/site_settings_exports.dart';
import '../presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import '../presentation/screens/main_screen.dart';
import '../services/profile_service.dart';

import '../../features/login/login_exports.dart';

import '../../features/profile/profile_exports.dart';

const String loginScreenRoute = "/login";
const String mainScreenRoute = "/main";
const String imageSelectorRoute = "/imageSelectorDialog";
const String profileScreenRoute = "profile";
const String siteSettingsScreenRoute = "siteSettings";
const String editMediaScreenRoute = "editMediaScreen";
const String editOrCreatePostRoute = "editOrCreatePostScreen";
const String createOrEditCategoryRoute = "createOrEditCategoryScreen";

final GetIt getIt = GetIt.instance;

final goRouter = GoRouter(
  initialLocation: loginScreenRoute,
  routes: [
    _loginScreenRoute(),
    _mainScreenRoute(),
    _imageSelectorDialog(),
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
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<SiteSettingsCubit>()),
                BlocProvider(create: (context) => getIt<ImageFinderCubit>()),
              ],
              child: const SiteSettingsScreen(),
            ),
          ),
          GoRoute(
            name: editMediaScreenRoute,
            path: editMediaScreenRoute,
            builder: (context, state) {
              final media = state.extra as MediaEntity;
              return EditMediaScreen(mediaEntity: media);
            },
          ),
          GoRoute(
            name: editOrCreatePostRoute,
            path: editOrCreatePostRoute,
            builder: (context, state) {
              final post = state.extra as PostEntity?;
              return BlocProvider(
                create: (context) => getIt<TagsCubit>(),
                child: EditOrCreatePostScreen(post: post),
              );
            },
          ),
          GoRoute(
            name: createOrEditCategoryRoute,
            path: createOrEditCategoryRoute,
            builder: (context, state) {
              final category = state.extra as CategoryEntity?;
              return CreateOrEditCategoryScreen(category: category);
            },
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
        create: (context) => GlobalProfileCubit(
          profileService: getIt<ProfileService>(),
        ),
      ),
      BlocProvider(create: (context) => getIt<MediaCubit>()),
      BlocProvider(create: (context) => getIt<PostsCubit>()),
      BlocProvider(create: (context) => getIt<CategoriesCubit>()),
    ],
    child: child,
  );
}

_imageSelectorDialog() {
  return GoRoute(
    name: imageSelectorRoute,
    path: imageSelectorRoute,
    builder: (context, state) => Builder(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<ImageListCubit>()),
        ],
        child: Scaffold(
          body: ImageSelectorScreen(
            onSelect: (media) => Navigator.of(context).pop(media),
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
      );
    }),
  );
}
