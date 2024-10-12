import 'package:flutter/material.dart';
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
        _profileAvatar(),
        _menu(),
      ],
    );
  }

  Widget _profileAvatar() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(100),
      child: const CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
          // TODO: get the url of profile
          "https://anjammidam.com/media/cache/thumb8_out/uploads/user/images/f2bf07bedcc23e4ca4a7a60c21df2a35.jpg",
        ),
      ),
    );
  }

  Widget _menu() {
    return IconButton(
      onPressed: () {},
      iconSize: 30,
      icon: const Icon(Icons.menu),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}
