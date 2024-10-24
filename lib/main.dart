import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dependency_injection.dart';
import 'word_press_companion_material_app.dart';

final DependencyInjection dependencyInjection =
    DependencyInjection(getIt: GetIt.instance);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependencyInjection.init();

  runApp(const WordpressCompanion());
}
