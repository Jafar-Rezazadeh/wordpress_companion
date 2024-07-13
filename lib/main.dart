import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/core/theme/theme.dart';
import 'package:wordpress_companion/dependency_injection.dart';

import 'core/router/go_router_config.dart';

void main() {
  initializeDependencyInjections();
  runApp(const WordpressCompanion());
}

class WordpressCompanion extends StatelessWidget {
  const WordpressCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        theme: lightTheme(),
        routerConfig: goRouter,
      ),
    );
  }
}
