import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:wordpress_companion/features/categories/categories_exports.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/posts/posts_exports.dart';
import '../../features/site_settings/site_settings_exports.dart';
import '../presentation/screens/main_screen.dart';

import '../../features/login/login_exports.dart';

import '../../features/profile/profile_exports.dart';

const String loginScreenRoute = "/login";
const String mainScreenRoute = "/main";
const String imageSelectorRoute = "/imageSelectorDialog";
const String profileScreenRoute = "/profile";
const String siteSettingsScreenRoute = "/siteSettings";
const String editMediaScreenRoute = "/editMediaScreen";
const String editOrCreatePostRoute = "/editOrCreatePostScreen";
const String createOrEditCategoryRoute = "/createOrEditCategoryScreen";

final GetIt getIt = GetIt.instance;

final getPagesConfig = <GetPage>[
  GetPage(
    name: loginScreenRoute,
    page: () => MultiBlocProvider(
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
  GetPage(
    name: mainScreenRoute,
    page: () => const MainScreen(),
  ),
  GetPage(
    name: profileScreenRoute,
    page: () => ProfileScreen(),
  ),
  GetPage(
    name: siteSettingsScreenRoute,
    page: () => MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SiteSettingsCubit>()),
        BlocProvider(create: (context) => getIt<ImageFinderCubit>()),
      ],
      child: const SiteSettingsScreen(),
    ),
  ),
  GetPage(
    name: editMediaScreenRoute,
    page: () {
      final media = Get.arguments as MediaEntity;
      return EditMediaScreen(mediaEntity: media);
    },
  ),
  GetPage(
    name: editOrCreatePostRoute,
    page: () {
      final post = Get.arguments as PostEntity?;
      return BlocProvider(
        create: (context) => getIt<TagsCubit>(),
        child: EditOrCreatePostScreen(post: post),
      );
    },
  ),
  GetPage(
    name: createOrEditCategoryRoute,
    page: () {
      final category = Get.arguments as CategoryEntity?;
      return CreateOrEditCategoryScreen(category: category);
    },
  ),
  GetPage(
    name: imageSelectorRoute,
    page: () => Builder(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<ImageListCubit>())
          ],
          child: const Scaffold(body: ImageSelectorScreen()),
        );
      },
    ),
  )
];
