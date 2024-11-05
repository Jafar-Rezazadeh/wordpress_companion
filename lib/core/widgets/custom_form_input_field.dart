import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constants.dart';
import '../theme/color_pallet.dart';

class CustomFormInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String label;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextDirection? textDirection;
  final String? hintText;
  final Function(String value)? onChanged;
  final int maxLines;
  final String? initialValue;
  final bool? enabled;
  final String? helperText;
  final FocusNode? focusNode;

  const CustomFormInputField({
    super.key,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.textDirection,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.onChanged,
    this.maxLines = 1,
    this.initialValue,
    this.enabled,
    this.helperText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      textDirection: textDirection,
      onChanged: onChanged,
      maxLines: maxLines,
      focusNode: focusNode,
      style: TextStyle(
        color: ColorPallet.text,
        fontSize: 12.sp,
      ),
      decoration: _inputDecoration(),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon,
      hintText: hintText,
      contentPadding:
          EdgeInsets.fromLTRB(16, _verticalPadding(), 16, _verticalPadding()),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(smallCornerRadius),
        borderSide: BorderSide(color: ColorPallet.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(smallCornerRadius),
        borderSide: BorderSide(color: ColorPallet.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(smallCornerRadius),
        borderSide: BorderSide(color: ColorPallet.midBlue),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(smallCornerRadius),
        borderSide: BorderSide(color: ColorPallet.border),
      ),
      helperText: helperText,
      helperStyle: const TextStyle(color: Colors.black54),
    );
  }

  double _verticalPadding() {
    if (maxLines > 1) {
      return 20;
    } else {
      return 5;
    }
  }
}
