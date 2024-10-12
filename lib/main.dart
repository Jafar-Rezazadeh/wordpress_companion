import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/core/theme/theme.dart';
import 'package:wordpress_companion/core/widgets/loading_widget.dart';
import 'package:wordpress_companion/dependency_injection.dart';

import 'core/router/go_router_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencyInjections();
  runApp(const WordpressCompanion());
}

class WordpressCompanion extends StatelessWidget {
  const WordpressCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: _materialApp(),
    );
  }

  MaterialApp _materialApp() {
    return MaterialApp.router(
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
