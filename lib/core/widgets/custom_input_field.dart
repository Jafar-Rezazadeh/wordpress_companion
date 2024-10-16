import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wordpress_companion/core/constants/constants.dart';
import 'package:wordpress_companion/core/theme/color_pallet.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? _validator;
  final String _label;
  final Widget? suffixIcon;
  final bool _obscureText;
  final TextDirection? _textDirection;
  final String? _hintText;

  const CustomInputField({
    super.key,
    required this.controller,
    required String label,
    String? Function(String?)? validator,
    this.suffixIcon,
    bool obscureText = false,
    TextDirection? textDirection,
    String? hintText,
  })  : _validator = validator,
        _label = label,
        _obscureText = obscureText,
        _textDirection = textDirection,
        _hintText = hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: _validator,
      obscureText: _obscureText,
      textDirection: _textDirection,
      style: TextStyle(
        color: ColorPallet.text,
        fontSize: 12.sp,
      ),
      decoration: _inputDecoration(),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      label: Text(_label),
      suffixIcon: suffixIcon,
      hintText: _hintText,
      contentPadding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
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
    );
  }
}
