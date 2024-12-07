import 'package:flutter/material.dart';
import '../core_export.dart';

class SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const SaveButton({
    this.text = "ذخیره",
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: ColorPallet.lightGreen),
        foregroundColor: ColorPallet.lightGreen,
      ),
      child: Text(text),
    );
  }
}
