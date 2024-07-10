import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/pages/first_page.dart';
import 'package:wordpress_companion/pages/second_page.dart';

import '../../pages/test_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const TestPage(),
    ),
    GoRoute(
      name: "first-page",
      path: "/first-page",
      builder: (context, state) => FirstPage(
        duration: state.extra as Duration,
      ),
    ),
    GoRoute(
      name: "second-page",
      path: "/second-page",
      builder: (context, state) => const SecondPage(),
    ),
  ],
);
