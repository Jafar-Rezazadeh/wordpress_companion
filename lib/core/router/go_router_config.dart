import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/core/presentation/screens/home_screen.dart';
import 'package:wordpress_companion/dependency_injection.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

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
