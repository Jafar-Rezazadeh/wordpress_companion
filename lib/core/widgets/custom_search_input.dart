import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wordpress_companion/core/core_export.dart';

class CustomSearchInput extends StatefulWidget {
  final Function(String? value) onSubmit;
  final Function() onClear;
  const CustomSearchInput({
    super.key,
    required this.onSubmit,
    required this.onClear,
  });

  @override
  State<CustomSearchInput> createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchInput> {
  bool playAnimation = false;

  final _controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(mediumCornerRadius),
      child: TextField(
        focusNode: focusNode,
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: _inputDecoration(),
        onChanged: (value) {
          setState(() => playAnimation = value.isNotEmpty ? true : false);
        },
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: InputBorder.none,
      filled: true,
      hintText: "جستجو...",
      prefixIcon: _prefixIcon(),
      suffixIcon: _controller.text.isNotEmpty ? _suffixIcon() : null,
      fillColor: ColorPallet.border,
    );
  }

  Widget _prefixIcon() {
    return IconButton(
      key: const Key("prefix_button"),
      icon: const Icon(Icons.search),
      onPressed: () {
        setState(() => playAnimation = false);
        focusNode.unfocus();
        widget.onSubmit(_controller.text);
      },
    ).animate(
      onComplete: (cont) => playAnimation == true ? cont.repeat() : null,
      target: playAnimation == true ? 1 : 0,
    )
      ..scaleXY(
        begin: 1,
        end: 1.1,
        delay: 1.seconds,
        duration: 100.milliseconds,
      )
      ..shake(delay: 1.seconds, duration: 500.milliseconds)
      ..then()
      ..scaleXY(begin: 1.1, end: 1, duration: 100.milliseconds);
  }

  Widget _suffixIcon() {
    return IconButton(
      key: const Key("suffix_button"),
      icon: const Icon(Icons.clear),
      onPressed: () {
        _controller.clear();
        setState(() => playAnimation = false);
        focusNode.unfocus();
        widget.onClear();
      },
    );
  }
}
