import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/presentation/cubits/global_profile_cubit/global_profile_cubit.dart';
import 'package:wordpress_companion/core/presentation/widgets/profile_avatar_widget.dart';
import 'package:wordpress_companion/core/utils/custom_url_launcher.dart';
import 'package:wordpress_companion/features/profile/domain/entities/profile_entity.dart';

import '../../router/go_router_config.dart';

class CustomDrawer extends StatelessWidget {
  final CustomUrlLauncher _customUrlLauncher;
  const CustomDrawer({
    super.key,
    required CustomUrlLauncher customUrlLauncher,
  }) : _customUrlLauncher = customUrlLauncher;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            _header(),
            _navigationItems(context),
            _bottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return BlocBuilder<GlobalProfileCubit, GlobalProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () => Container(),
          loading: () => const LoadingWidget(),
          loaded: (profile) => _userAccountHeader(context, profile),
          error: (failure) => FailureWidget(failure: failure),
        );
      },
    );
  }

  Widget _userAccountHeader(BuildContext context, ProfileEntity profile) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: DividerThemeData(color: ColorPallet.border),
      ),
      child: UserAccountsDrawerHeader(
        accountName: Text(
          "${profile.firstName} ${profile.lastName}",
          style: TextStyle(color: ColorPallet.text),
        ),
        accountEmail: Text(
          profile.email,
          style: TextStyle(color: ColorPallet.text),
        ),
        currentAccountPicture: const ProfileAvatarWidget(),
        decoration: BoxDecoration(
          color: ColorPallet.white,
        ),
      ),
    );
  }

  Widget _navigationItems(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _siteSettingsNav(context),
        ],
      ),
    );
  }

  ListTile _siteSettingsNav(BuildContext context) {
    return ListTile(
      key: const Key("site_settings_nav"),
      leading: const Icon(Icons.settings),
      onTap: () => context.goNamed(siteSettingsScreenRoute),
      title: const Text("تنظیمات سایت"),
    );
  }

  Widget _bottomSection() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: ColorPallet.border)),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            _aboutDeveloper(),
            _socialLinks(),
          ],
        ),
      ),
    );
  }

  Widget _aboutDeveloper() {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              "درباره سازنده:",
              style: TextStyle(color: ColorPallet.text, fontSize: 11.sp),
            ),
          ),
          const Gap(5),
          Flexible(
            fit: FlexFit.loose,
            child: SelectableText(
              "جعفر رضازاده توسعه دهنده نرم افزار برای پلتفرم های مختلف. \n ایمیل: jafarrezazadeh76@gmail.com ",
              style: TextStyle(fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialLinks() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 2,
            child: Text("راه های ارتباطی:",
                style: TextStyle(color: ColorPallet.text, fontSize: 0.03.sw)),
          ),
          _bottomBarItem(
            key: const Key("telegram_button"),
            icon: FontAwesomeIcons.telegram,
            onPressed: () async {
              await _customUrlLauncher.openInBrowser("https://t.me/jafar_rzzd");
            },
          ),
          _bottomBarItem(
            key: const Key("github_button"),
            onPressed: () async {
              await _customUrlLauncher
                  .openInBrowser("https://github.com/Jafar-Rezazadeh");
            },
            icon: FontAwesomeIcons.github,
          ),
          _bottomBarItem(
            key: const Key("email_button"),
            onPressed: () async {
              await _customUrlLauncher
                  .openInBrowser("https://mailto:jafarrezazadeh76@gmail.com");
            },
            icon: FontAwesomeIcons.envelope,
          )
        ],
      ),
    );
  }

  Widget _bottomBarItem({
    Key? key,
    required Function()? onPressed,
    required IconData icon,
  }) {
    return Expanded(
      key: key,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: ColorPallet.text,
        iconSize: 0.06.sw,
      ),
    );
  }
}
