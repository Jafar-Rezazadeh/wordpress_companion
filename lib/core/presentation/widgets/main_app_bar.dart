import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'profile_avatar_widget.dart';
import '../../theme/color_pallet.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _profile(),
      backgroundColor: ColorPallet.white,
      surfaceTintColor: ColorPallet.white,
      elevation: 5,
      shadowColor: Colors.black54,
      leadingWidth: 50,
      actions: _actions(context),
      automaticallyImplyLeading: false,
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      IconButton(
        key: const Key("drawer_button"),
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
      const Gap(0),
    ];
  }

  Widget _profile() {
    return const Padding(
      padding: EdgeInsets.only(left: 15),
      child: ProfileAvatarWidget(),
    );
  }

  @override
  Size get preferredSize =>
      Size(double.infinity, AppBar().preferredSize.height);
}
