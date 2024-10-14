import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/features/login/login_exports.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/router/go_router_config.dart';
import '../../../../core/widgets/failure_widget.dart';

class AuthenticationStateListener {
  final BuildContext context;
  final AuthenticationState state;

  AuthenticationStateListener({required this.context, required this.state});

  listen() {
    state.when(
      initial: () => null,
      authenticating: () {
        FocusScope.of(context).unfocus();
        context.loaderOverlay.show();
        return null;
      },
      authenticationFailed: (failure) {
        context.loaderOverlay.hide();
        _showFailureInModalBottomSheet(failure);
        return null;
      },
      authenticated: (credentials) {
        context.loaderOverlay.hide();
        context.goNamed(mainScreen, extra: credentials);
        _showSnackBar(content: "ورود با موفقیت انجام شد");
        return null;
      },
      notValidUser: () {
        context.loaderOverlay.hide();
        _showSnackBar(content: "نام کاربری یا رمز عبور اشتباه است");
        return null;
      },
    );
  }

  _showFailureInModalBottomSheet(Failure failure) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => FailureWidget(failure: failure),
    );
  }

  _showSnackBar({required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
