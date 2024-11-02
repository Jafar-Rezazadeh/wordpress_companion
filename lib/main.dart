import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';
import 'dependency_injection.dart';
import 'word_press_companion_material_app.dart';

final DependencyInjection dependencyInjection =
    DependencyInjection(getIt: GetIt.instance);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFlutterDownloader();

  // HACK: remove this in production
  HttpOverrides.global = MyHttpOverrides();

  await dependencyInjection.init();

  runApp(const WordpressCompanion());
}

Future<void> initFlutterDownloader() async {
  await FlutterDownloader.initialize(
    debug: true,
    // HACK: remove this in production
    ignoreSsl: true,
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final httpClient = super.createHttpClient(context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return httpClient;
  }
}
