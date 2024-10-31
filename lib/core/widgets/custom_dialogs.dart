import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/core_export.dart';

class CustomDialogs {
  static showAreYouSureDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        key: const Key("are_you_sure_dialog"),
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(title),
          content: Text(content),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              key: const Key("cancel_button"),
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("خیر"),
            ),
            TextButton(
              key: const Key("confirm_button"),
              onPressed: () {
                onConfirm();
                Navigator.pop(dialogContext);
              },
              style: TextButton.styleFrom(
                overlayColor: ColorPallet.crimson,
                foregroundColor: ColorPallet.crimson,
              ),
              child: const Text("بله"),
            ),
          ],
        ),
      ),
    );
  }
}
