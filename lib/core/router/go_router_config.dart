import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/presentation/screens/home_screen.dart';
import 'package:wordpress_companion/dependency_injection.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

const String loginScreen = "/loginScreen";
const String mainScreen = "/mainScreen";
// const String postScreen = "/post";
// const String postsScreen = "/posts";
// const String profileScreen = "/profile";
// const String settingsScreen = "/settings";

final goRouter = GoRouter(
  initialLocation: loginScreen,
  routes: [
    ShellRoute(
      builder: (context, state, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthenticationCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<LoginCredentialsCubit>(),
          ),
        ],
        child: child,
      ),
      routes: [
        GoRoute(
          name: loginScreen,
          path: loginScreen,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: mainScreen,
          path: mainScreen,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    )
  ],
);
