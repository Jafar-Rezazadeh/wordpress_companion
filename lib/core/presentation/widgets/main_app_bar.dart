import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/router/go_router_config.dart';
import 'package:wordpress_companion/core/theme/color_pallet.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ImageProvider? imageProviderTest;
  const MainAppBar({super.key, this.imageProviderTest});

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
      child: _actions(context),
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

  Row _actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _profileAvatar(context),
        _menu(),
      ],
    );
  }

  Widget _profileAvatar(BuildContext context) {
    return InkWell(
      key: const Key("profile_avatar"),
      onTap: () => context.goNamed(profileScreen),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: imageProviderTest ??
            const NetworkImage(
              // TODO: get the url of profile
              "https://anjammidam.com/media/cache/thumb8_out/uploads/user/images/f2bf07bedcc23e4ca4a7a60c21df2a35.jpg",
            ),
      ),
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
