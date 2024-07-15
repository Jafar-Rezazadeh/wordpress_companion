import 'package:flutter/material.dart';

class QuickAccessButtons extends StatefulWidget {
  const QuickAccessButtons({super.key});

  @override
  State<QuickAccessButtons> createState() => _QuickAccessButtonsState();
}

class _QuickAccessButtonsState extends State<QuickAccessButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: _listOfButtons(),
    );
  }

  Widget _listOfButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _button(
          label: "نوشته ها",
          child: const Icon(Icons.push_pin),
          onTap: () {},
        ),
        _button(
          label: "رسانه",
          child: const Icon(Icons.image),
          onTap: () {},
        ),
        _button(
          label: "صفحات",
          child: const Icon(Icons.pages),
          onTap: () {},
        ),
        _button(
          child: const Icon(Icons.comment),
          onTap: () {},
          label: "نظرات",
        ),
      ],
    );
  }

  Widget _button({
    required Widget child,
    required VoidCallback onTap,
    required String label,
  }) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 60,
            minWidth: 60,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
