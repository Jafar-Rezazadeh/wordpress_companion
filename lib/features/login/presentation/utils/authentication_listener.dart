import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wordpress_companion/core/widgets/custom_bottom_sheet.dart';
import '../../login_exports.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/router/router_config.dart';

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
          (timeStamp) => Get.offNamed(mainScreenRoute, arguments: credentials),
        );

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
      (timeStamp) => CustomBottomSheets.showFailureBottomSheet(
        context: context,
        failure: failure,
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
