import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'core/core_export.dart';

import 'core/services/profile_service.dart';
import 'core/theme/theme.dart';
import 'features/categories/categories_exports.dart';
import 'features/media/media_exports.dart';
import 'features/posts/posts_exports.dart';

class WordpressCompanion extends StatelessWidget {
  const WordpressCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _getMaterialApp(),
      ),
    );
  }

  Widget _getMaterialApp() {
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
      child: GetMaterialApp(
        initialRoute: loginScreenRoute,
        getPages: getPagesConfig,
        locale: const Locale("fa", "IR"),
        supportedLocales: const [
          Locale("fa", "IR"),
          Locale("en", "US"),
        ],
        localizationsDelegates: const [
          // Add Localization
          PersianMaterialLocalizations.delegate,
          PersianCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: CustomTheme().lightTheme(),
        builder: (context, child) => GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayColor: Colors.transparent,
          overlayWidgetBuilder: (_) => _loaderOverlayWidget(context),
          duration: Durations.medium1,
          child: child ?? Container(),
        ),
      ),
    );
  }

  Widget _loaderOverlayWidget(BuildContext context) {
    return BackdropFilter(
      key: const Key("loading_overlay"),
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: const Center(
        child: LoadingWidget(),
      ),
    );
  }
}
