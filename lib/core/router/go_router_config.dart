import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/core/screens/home.dart';
import 'package:wordpress_companion/dependency_injection.dart';
import 'package:wordpress_companion/features/user-login/user_login_exports.dart';

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      builder: (context, state, child) => BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: child,
      ),
      routes: [
        GoRoute(
          name: loginScreen,
          path: "/",
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: homeScreen,
          path: "/home",
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    )
  ],
);
