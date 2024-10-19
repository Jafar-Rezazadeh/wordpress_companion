import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/presentation/widgets/profile_avatar_widget.dart';
import 'package:wordpress_companion/core/theme/color_pallet.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.paddingOf(context).top,
        16,
        0,
      ),
      decoration: _containerDecoration(),
      child: _actions(),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: ColorPallet.white,
      boxShadow: [
        BoxShadow(
          color: ColorPallet.lowBackGround,
          spreadRadius: 10,
          blurRadius: 10,
          blurStyle: BlurStyle.normal,
        ),
        const BoxShadow(
          color: Colors.black12,
          spreadRadius: 3,
          blurRadius: 2,
          blurStyle: BlurStyle.normal,
        ),
      ],
    );
  }

  Row _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ProfileAvatarWidget(),
        _menu(),
      ],
    );
  }

  Widget _menu() {
    return PopupMenuButton(
      iconSize: 30,
      itemBuilder: (context) => [
        PopupMenuItem(
          child: const Text("تنظیمات سایت"),
          onTap: () {
            // TODO: navigate to settings page
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}
