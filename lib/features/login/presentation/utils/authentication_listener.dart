import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../login_exports.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/router/go_router_config.dart';
import '../../../../core/widgets/failure_widget.dart';

class AuthenticationStateListener {
  final BuildContext context;
  final AuthenticationState state;

  AuthenticationStateListener({required this.context, required this.state});

  when() {
    state.when(
      initial: () => null,
      authenticating: () {
        FocusScope.of(context).unfocus();
        context.loaderOverlay.show();
        return;
      },
      authenticationFailed: (failure) {
        context.loaderOverlay.hide();
        _showFailureInModalBottomSheet(failure);
      },
      authenticated: (credentials) {
        context.loaderOverlay.hide();
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => context.goNamed(mainScreenRoute, extra: credentials),
        );
        _showSnackBar(content: "ورود با موفقیت انجام شد");
        return;
      },
      notValidUser: () {
        context.loaderOverlay.hide();
        _showSnackBar(content: "نام کاربری یا رمز عبور اشتباه است");
        return;
      },
    );
  }

  _showFailureInModalBottomSheet(Failure failure) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => FailureWidget(failure: failure),
      ),
    );
  }

  _showSnackBar({required String content}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
