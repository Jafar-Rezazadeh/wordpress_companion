import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/pages/first_page.dart';
import 'package:wordpress_companion/pages/second_page.dart';

import '../../cubit/counter_cubit.dart';
import '../../pages/test_page.dart';

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      builder: (context, state, child) => BlocProvider(
        create: (context) => CounterCubit(),
        child: child,
      ),
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => const TestPage(),
        ),
        GoRoute(
          name: "first-page",
          path: "/first-page",
          builder: (context, state) => FirstPage(
            duration: state.extra as Duration?,
          ),
        ),
        GoRoute(
          name: "second-page",
          path: "/second-page",
          builder: (context, state) => const SecondPage(),
        ),
      ],
    ),
  ],
);
