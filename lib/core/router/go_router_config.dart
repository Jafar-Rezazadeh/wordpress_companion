import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/constants/constants.dart';

final goRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: loginScreen,
      path: "/",
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text("login screen"),
        ),
      ),
    ),
  ],
);
