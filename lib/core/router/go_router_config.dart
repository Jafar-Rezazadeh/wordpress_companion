import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/features/user-login/presentation/screens/login_screen.dart';

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: loginScreen,
      path: "/",
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
