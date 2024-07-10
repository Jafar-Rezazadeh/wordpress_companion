import 'package:flutter/material.dart';

import 'core/router/go_router_config.dart';

void main() {
  runApp(const WordpressCompanion());
}

class WordpressCompanion extends StatelessWidget {
  const WordpressCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
    );
  }
}
