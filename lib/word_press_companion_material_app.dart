import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'core/core_export.dart';

import 'core/theme/theme.dart';

class WordpressCompanion extends StatelessWidget {
  const WordpressCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _materialApp(),
      ),
    );
  }

  MaterialApp _materialApp() {
    return MaterialApp.router(
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
      routerConfig: goRouter,
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
